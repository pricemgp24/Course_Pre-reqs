from PyQt5.QtWidgets import QApplication
from pycalc.views import CalculatorWindow
from pycalc.controller import CalculatorController
import sys

def main():
    app = QApplication(sys.argv)
    view = CalculatorWindow()
    controller = CalculatorController(view)  # ✅ Attach controller logic
    view.show()
    sys.exit(app.exec_())