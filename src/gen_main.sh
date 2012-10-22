#!/bin/sh -e

echo open Server > main.ml
echo "let _ = OS.Main.run (main ())" >> main.ml
