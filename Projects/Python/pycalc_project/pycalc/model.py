def evaluate_expression(expression):
    try:
        result = str(eval(expression))
    except Exception:
        result = "ERROR"
    return result