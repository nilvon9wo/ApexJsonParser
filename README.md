# ApexJsonParser
This is a Proof of Concept, not intended for production use (use SFDC's native JSON parser).

This is inspired by a tutorial demonstrating how to create a JSON parser in Python:
http://notes.eatonphil.com/writing-a-simple-json-parser.html

However, this is not a simple transcription from Python to Apex.
The languages are too different for that.
Also, I wanted to apply object-oriented and functional programming principles.

This implementation includes types for "Option" (OPT_Option/OPT_Some/OPT_None) and "Immutable Lists" (IMUT_ImmutableList).
These are fully functional, though they sacrifice type safety.
Also, I expect IMUT_ImmutableList will perform very badly as all its methods require cloning.
