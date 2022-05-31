#!/bin/bash

echo "[LEXER+PARSER]"
java -classpath ~/lib/antlr-3.3-complete.jar org.antlr.Tool CA.g
echo "[TREEPARSER]"
java -classpath ~/lib/antlr-3.3-complete.jar org.antlr.Tool CA2Internal.g
