#!/usr/bin/env bash

rsync --update --delete -raz --progress jigen:pkm $HOME

