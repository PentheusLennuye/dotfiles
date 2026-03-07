#!/usr/bin/env bash

rsync --update --delete -raz --progress $HOME/pkm jigen:

