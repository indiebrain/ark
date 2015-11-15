defmodule Ark.XmlParser do

  import Ark.Exceptions.UnmatchedXPathError

  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def document_from_string(string) do
    char_list = String.to_char_list(string)
    { document, _rest } = :xmerl_scan.string(char_list)
    document
  end

  def element_at(xpath, document) do
    try do
      [ element ] = :xmerl_xpath.string(xpath, document)
      element
    rescue
      MatchError -> raise Ark.Exceptions.UnmatchedXPathError, message: "no element at path #{xpath}"
    end
  end

  def value_at(xpath, document) do
    element = element_at(xpath, document)
    [ element_content ] = xmlElement(element, :content)
    xmlText(element_content, :value)
  end
end
