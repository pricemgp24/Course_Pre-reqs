from PyQt5.QtWidgets import QWidget, QLineEdit, QPushButton, QGridLayout, QVBoxLayout
from PyQt5.QtCore import Qt

class CalculatorWindow(QWidget):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("PyQt Calculator")
        self.setFixedSize(300, 400)

        self.create_widgets()
        self.create_layout()
        self.create_connections()

    def create_widgets(self):
        self.display = QLineEdit()
        self.display.setReadOnly(True)
        self.display.setAlignment(Qt.AlignRight)
        self.display.setFixedHeight(40)
        self.display.setFocusPolicy(Qt.NoFocus)  # ✅ Fix for Enter key handling

        self.buttons = {}
        keys = [
            '7', '8', '9', '/', 
            '4', '5', '6', '*',
            '1', '2', '3', '-', 
            '0', '.', '=', '+',
            'C'
        ]
        for key in keys:
            self.buttons[key] = QPushButton(key)
            self.buttons[key].setFixedSize(60, 40)

    def create_layout(self):
        main_layout = QVBoxLayout()
        main_layout.addWidget(self.display)

        grid = QGridLayout()
        positions = [(i, j) for i in range(5) for j in range(4)]        
        keys = list(self.buttons.keys())

        for position, key in zip(positions, keys):
            grid.addWidget(self.buttons[key], *position)

        main_layout.addLayout(grid)
        self.setLayout(main_layout)

    def create_connections(self):
        for key, button in self.buttons.items():
            # Lambda fix ensures correct key capture
            button.clicked.connect(lambda _, k=key: self.on_button_click(k))

    def on_button_click(self, key):
        # This will be overridden by the controller
        pass

    def keyPressEvent(self, event):
        key = event.key()
        if key in (Qt.Key_Return, Qt.Key_Enter):
            self.on_button_click("=")
        elif Qt.Key_0 <= key <= Qt.Key_9:
            self.on_button_click(str(key - Qt.Key_0))
        elif key == Qt.Key_Plus:
            self.on_button_click("+")
        elif key == Qt.Key_Minus:
            self.on_button_click("-")
        elif key == Qt.Key_Asterisk:
            self.on_button_click("*")
        elif key == Qt.Key_Slash:
            self.on_button_click("/")
        elif key == Qt.Key_Period:
            self.on_button_click(".")
        elif key == Qt.Key_Delete:
            self.on_button_click("C")