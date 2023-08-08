# Policy Number Challenge

The Policy Number Challenge is a Ruby program designed to process OCR-encoded policy numbers. It includes various modules that handle OCR conversion, policy number validation, and correction. This application is capable of reading input files, processing data, and generating output files.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Usage](#usage)
- [Dependencies](#dependencies)
- [Testing](#testing)

## Features

- OCR conversion of policy numbers
- Validation of policy numbers based on checksum
- Correction of policy numbers with potential errors

## Getting Started

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/jamesgarnerdev/policy_number_challenge

2. **Navigate to the Project Directory**

   ```bash
   cd policy-number-challenge-boilerplate/lib

3. **Install Ruby (if not already installed)**

   Ensure you have Ruby installed on your system. You can check the version by running:

   ```ruby
   ruby -v

   If Ruby is not installed, you can download and install it from the official Ruby website.

3. **Install Dependencies**

   Install the required Ruby gems (dependencies) by running:

   ```ruby
   gem install bundler
   bundle install

### Usage

1. **Modify Input Files**

   Place the OCR-encoded policy numbers you want to process in a text file (e.g., `sample.txt`).

2. **Run the Main Application**

   Execute the main application script `main.rb`, providing the input and output file paths as arguments:

   ```ruby
   ruby main.rb

### Dependencies

1. **Ruby**

   Ruby version 3.1.2 is required

2. **Rspec**

   Rspec for testing

### Testing

    The Policy Number Challenge comes with a comprehensive suite of automated tests that ensure its accuracy and functionality. These tests cover a range of scenarios, including valid and invalid inputs, OCR conversion, policy validation, and correction.

1. **Running Tests**

   To run the tests, navigate to the project spec directory and execute the provided command:

   ```bash
   cd policy-number-challenge-boilerplate/spec
   rspec .
