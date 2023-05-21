import 'dart:io';

void main() {
  final file = File('song.txt');

  var wordList = [];
  var chordList = [];
  var spacesList = [];

  // Read the content of the text file
  final lines = file.readAsLinesSync();

  // Iterate through each line
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final words = line.split(' ');

    for (var j = 0; j < words.length; j++) {
      final word = words[j];

      // Ask the user if they want to add a chord to the word
      stdout.write('Do you want to add a chord to "$word"? (Y/N): ');
      String answer = stdin.readLineSync().toString();

      // If the user says they want to add a chord to that word
      if (answer.toLowerCase() == "y") {
        print("What letter would you like to assign to the word?");
        final letterToInsert = stdin.readLineSync().toString();
        final wordToFind = word;
        final selectedInstance = 1;

        chordList.add(letterToInsert);
        wordList.add(wordToFind);

        // Read the content of the text file
        final lines = file.readAsLinesSync();

        // Find the index of the chosen word and instance
        var count = 0;
        var index = -1;
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i];
          final words = line.split(' ');

          for (var j = 0; j < words.length; j++) {
            if (words[j] == wordToFind) {
              count++;
              if (count == selectedInstance) {
                index = i;
                break;
              }
            }
          }

          if (index != -1) {
            break;
          }
        }

        if (index != -1) {
          // Count the number of characters before the chosen word
          final charsBeforeWord = lines[index].indexOf(wordToFind);

          // Generate the spaces string
          final spaces = ' ' * charsBeforeWord;

          spacesList.add(charsBeforeWord);

          // Insert the spaces and the letter above the found index
          lines.insert(index, spaces + letterToInsert);
        }

        // Write the modified content back to the text file
        file.writeAsStringSync(lines.join('\n'));

        print(wordList);
        print(chordList);
        print(spacesList);
      }
    }
  }
}
