from pycalc.model import evaluate_expression

class CalculatorController:
    def __init__(self, view):
        self.view = view
        self.expression = ""

        # Connect controller logic to the view’s button handler
        self.view.on_button_click = self.handle_input

    def handle_input(self, key):
        if key == "C":
            self.expression = ""
        elif key == "=":
            self.expression = evaluate_expression(self.expression)
        else:
            self.expression += key

        self.view.display.setText(self.expression)