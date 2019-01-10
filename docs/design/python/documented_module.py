"""The example_documentation module shows how a module in an Azure SDK component should look.
"""

class ClassWithExample(object):
  """ A collection of mathematical functions

  The methods of this class are only for show. They don't acutally have a method body. But they
  do have beautiful and relevant documentation. 
  
  :ivar last_factorial: The result of the last factorial computed
  """

  def __init__(self, seed:"int"=7):
    self.last_factorial = -1


  def calculate_factorial(self, value: "int", fail_if_bigger_than: "int"=None) -> "int":
    """ Calculate the factorial of `value`
    :param value: The value for which the factorial is to compted.
    :param fail_if_bigger_than: Raise a `ValueError` if the value is greater than the provided value.
    :raise ValueError: If result is greater than fail_if_bigger_than.

    .. literalinclude:: ../../examples/class_with_example.py
    :start-after: [START calculate_factorial]
    :end-before: [END calculate_factorial]
    :language: python
    :dedent: 0
    :caption: Calculate the factorial of 4711:
    :name: calculate_factorial
    """
    pass