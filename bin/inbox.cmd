@echo off
rem Windows entry point. Claude Code adds bin\ to PATH when the plugin is enabled.
python "%~dp0..\inbox\inbox.py" %*
