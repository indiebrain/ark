defmodule Ark.XmlParserTest do

  require Record

  use ExUnit.Case
  import Ark.XmlParser

  test "document_from_string creates an xml document object when given valid xml" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
      </second_element>
    </example>
    """

    document = document_from_string(xml_string)

    assert(Record.is_record(document, :xmlElement))
  end

  test "document_from_string fatally exits when given malformed xml" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
    </example>
    """

    parse_result = catch_exit(document_from_string(xml_string))

    assert(
      { :fatal, _ } = parse_result
    )
  end

  test "element_at returns the xmlElement when the given xpath is found" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
      </second_element>
    </example>
    """
    document = document_from_string(xml_string)

    element = element_at('/example/second_element', document)

    assert(Record.is_record(element, :xmlElement))
  end

  test "element_at raises an UnmatchedXPathError when the given xpath is not found" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
      </second_element>
    </example>
    """
    document = document_from_string(xml_string)

    assert_raise(
      Ark.Exceptions.UnmatchedXPathError,
      "no element at path /example/third_element",
      fn () ->
        element_at('/example/third_element', document)
      end
    )
  end

  test "value_at returns a String (character list) representation of the value of the element at the given XPath when the xpath is found" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
      </second_element>
    </example>
    """
    document = document_from_string(xml_string)

    assert(
      'first_element_value' == value_at('/example/first_element', document)
    )
  end

  test "value_at raises an UnmatchedXPathError when the xpath is not found" do
    xml_string = """
    <example>
      <first_element>first_element_value</first_element>
      <second_element second_element_attribute="second_element_attribute_value">
        second_element_value
      </second_element>
    </example>
    """
    document = document_from_string(xml_string)

    assert_raise(
      Ark.Exceptions.UnmatchedXPathError,
      "no element at path /example/third_element",
      fn () ->
        value_at('/example/third_element', document)
      end
    )
  end
end
