#!/usr/bin/env python3
from PyQt5.QtWidgets import QApplication, QMainWindow, QPushButton
from PyQt5 import sip
app = QApplication([])
mainWin = QMainWindow()
button = QPushButton("Hello, PyQt5!")
mainWin.setCentralWidget(button)
mainWin.show()
app.exec_()