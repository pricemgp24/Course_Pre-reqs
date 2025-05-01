PyQt Calculator

A simple desktop calculator built with Python and PyQt5, using the Model-View-Controller (MVC) design pattern.

This project allows basic arithmetic operations with both mouse clicks and keyboard input.

⸻

Features
	•	Responsive GUI with PyQt5
	•	Mouse and keyboard input support
	•	Full MVC architecture
	•	Error handling for invalid input
	•	Clear (C) button and Delete key support
	•	Expressions evaluated using eval() (can later be secured with ast or sympy)

⸻

Project Structure

pycalc_project/
├── pycalc/
│   ├── __init__.py
│   ├── controller.py
│   ├── main.py
│   ├── model.py
│   └── views.py
├── run_pycalc.py
├── README.md
└── requirements.txt



⸻

How to Run
	1.	Clone the project:

git clone https://github.com/yourusername/pyqt-calculator.git
cd pyqt-calculator


	2.	Create a virtual environment (optional):

python3 -m venv venv
source venv/bin/activate


	3.	Install requirements:

pip install -r requirements.txt


	4.	Run the application:

python run_pycalc.py



⸻

Keyboard Shortcuts
	•	0–9 and operators: standard typing
	•	Enter: evaluate (=)
	•	Delete: clear all (C)
	•	Mouse clicks also fully supported

⸻

Dependencies
	•	Python 3.6+
	•	PyQt5

Add to requirements.txt:

PyQt5>=5.15.0



⸻

Future Improvements
	•	Add backspace key (⌫) support
	•	Scientific functions (sqrt, ^, log, etc.)
	•	Use a safer parser instead of eval()
	•	Theme support or styling

⸻