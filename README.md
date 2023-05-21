# Overview

I have developed a software application called Chordifier to demonstrate the Dart language. The purpose of this software is to enable users to add chords on top of lyrics, facilitating the process of playing songs. By integrating chords with lyrics, musicians and songwriters can conveniently visualize and play their favorite songs.

The primary aim of developing Chordifier is to showcase the capabilities of the Dart language and its suitability for building practical applications. Through this project, I wanted to demonstrate how Dart can be used to create a user-friendly and functional program that addresses a specific need in the music domain. This is my first Dart program so choosing something I was interested in helped me learn the ins and outs of Dart.

[Software Demo Video](https://youtu.be/iJIr_O9JXic)

# Development Environment

To develop ChordLyrics, I used the following tools:

IDE: I utilized Visual Studio Code as my integrated development environment (IDE) due to its excellent Dart support and extensive plugin ecosystem.
Dart SDK: I leveraged the official Dart SDK to write and execute Dart code.

To run the project, I had to import'dart:io'; and 'dart:async';

# Useful Websites

Throughout the development process of Chordifier, I found the following websites to be particularly helpful:

- [W3 Schools](https://www.w3schools.io/languages/dart-tutorials/)
- [Dart.dev](https://dart.dev/tutorials)

# Future Work

- Transposing - I was planning on implemnting a transposer to these chords for when I encounter chords that I can't play very well. Or if I simply want the song in another key. As I was trying to develop this feature, I ran into problems with transposing all of the Chords at the same time without interfering with each other. If I wanted to change all C chords to F, and all F chords to G, my program would change all F chords to G including the ones that had previously been changed from C. I need to find a way to fix this in the future.
- I would like to use dart to make this a functioning app with UI. Dart has great UI features that I did not harness in this project.
- Right now, Chordifier only works with major and # chords. If you want to enter Bb or Bm, they will appear as BB and BM. I need to find a way to include these chords in the proper case while still customizing the format so the program will run well.
- Support more file formats: I want to extend the program's capability to import and export lyrics and chords in various file formats, such as plain text or popular song file formats.
