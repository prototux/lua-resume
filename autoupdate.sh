#!/bin/bash

while inotifywait -qe modify ./data-fr.lua
do
	./generate.lua
done
