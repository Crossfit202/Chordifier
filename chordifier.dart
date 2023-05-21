import 'dart:io';
import 'dart:async';

var chords = [];
var changedChords = [];

int countCharactersBeforeWord(String text, String word) {
  // Initialize count to 0
  int count = 0;
  // Find the index of the word in the text
  int index = text.indexOf(word);

  // If the word is found in the text
  if (index != -1) {
    // Update count to the index value
    count = index;
  }

  // Return the count of characters before the word
  return count;
}

void addLineAboveMatchedLine(
    String filePath, String searchLine, String newLine) {
  // Create a File object with the provided filePath
  File file = File(filePath);
  // Read all lines from the file and store them in a list
  List<String> lines = file.readAsLinesSync();
  // Initialize a boolean variable to track if a match is found
  bool matchFound = false;

  // Iterate through each line in the list
  for (int i = 0; i < lines.length; i++) {
    // Check if the current line matches the searchLine
    if (lines[i] == searchLine) {
      // Insert the newLine above the matched line
      lines.insert(i, newLine);
      // Set matchFound to true to indicate a match is found
      matchFound = true;
      // Exit the loop since a match is found
      break;
    }
  }

  // If a match is found
  if (matchFound) {
    // Write the modified lines back to the file
    file.writeAsStringSync(lines.join('\n'));
  }
}

Future<void> appendStringToFile(String content, String filePath) async {
  // Create a File object with the provided filePath
  File file = File(filePath);
  // Declare an IOSink variable to write to the file
  IOSink sink;

  try {
    // Open the file in append mode and assign the sink
    sink = file.openWrite(mode: FileMode.append);
    // Write the lowercase content to the file
    sink.write(content.toLowerCase());
    // Flush the sink to ensure the content is written
    await sink.flush();
    // Close the sink to release system resources
    await sink.close();
    // Print a message indicating successful operation
    print('Line added and file closed.');
  } catch (error) {
    // Print an error message if an exception occurs
    print('Error: $error');
  }
}

Future<void> enterSongLines(String filePath) async {
  Completer<void> completer = Completer<void>();
  bool finished = false;
  String line;
  String song = '';

  print('Enter the lines of your song. Type ` when you\'re finished.');

  while (!finished) {
    line = stdin.readLineSync() ?? '';
    if (line.trim() == '`') {
      finished = true;
    } else {
      song += line + '\n';
    }
  }

  if (song.isNotEmpty) {
    await appendStringToFile(song, filePath); // Wait for the file to be closed
  } else {
    print('No lines entered.');
  }

  completer.complete(); // Resolve the completer
  return completer.future; // Return the future
}

void collectChords(String filename) {
  // Create a File object with the provided filename
  final file = File(filename);
  // Read all lines from the file and store them in a list
  final lines = file.readAsLinesSync();

  // Iterate through each line in the list
  for (var line in lines) {
    // Initialize an empty list to store chords
    List<String> chordList = [];
    // Initialize an empty list to store spaces
    List<int> spacesList = [];
    // Initialize an empty list to store the final modified line
    var finalList = [];

    // Split the line into individual words
    var words = line.split(' ');

    // Iterate through each word in the line
    for (var i = 0; i < words.length; i++) {
      var word = words[i];

      // Prompt the user to add a letter to the current word
      stdout.write('Do you want to add a letter to "$word"? (y/n): ');
      var input = stdin.readLineSync();

      if (input?.toLowerCase() == 'y') {
        // Add the count of characters before the current word to spacesList
        spacesList.add(countCharactersBeforeWord(line, word));

        // Prompt the user to enter the letter to add
        stdout.write('Enter the letter you want to add: ');
        var letter = stdin.readLineSync().toString();
        chordList.add(letter.toUpperCase());

        // Add the letter to the 'chords' list if it doesn't already exist
        if (!chords.contains(letter)) {
          chords.add(letter);
        }
      }
    }

    int previousSpaces = 0;

    if (chordList.length == spacesList.length) {
      for (int i = 0; i < chordList.length; i++) {
        String value1 = chordList[i];
        int value2 = spacesList[i];
        int spaces = value2 - previousSpaces;

        previousSpaces = value2 + 1;

        // Add the spaces and chord to the finalList
        finalList.add(' ' * (spaces));
        finalList.add(value1);
      }
    }

    String finalString = '';

    // Concatenate the elements of finalList into a single string
    for (var i in finalList) {
      finalString = finalString + i;
    }

    // Add the modified line above the matched line in the file
    addLineAboveMatchedLine('song.txt', line, finalString);
  }
}

void main() async {
  String filePath = 'song.txt';

  // Print welcome message
  print('\nWelcome to the Song Chordifier\n');

  // Print menu options
  print('Menu:');
  print(' 1. Enter in your own lyrics');
  print(' 2. Read lyrics from file');

  // Prompt user for menu option
  print('\n Enter the menu option you would like to perform:');

  // Read and parse user input
  int userInput = int.parse(stdin.readLineSync().toString());

  if (userInput == 1) {
    // If user chooses option 1, await song lines to be entered and the file to be closed
    await enterSongLines(filePath);

    // Proceed to collect chords
    collectChords(filePath);
  }

  if (userInput == 2) {
    // If user chooses option 2, prompt for the file to read from
    print('What file would you like to read from?');
    String file = stdin.readLineSync().toString();

    // Collect chords from the specified file
    collectChords(file);
  }
}
