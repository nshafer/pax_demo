defmodule Parse do
  def parse_list(list) do
    Enum.map(list, &parse_entry/1)
  end

  def parse_entry(m) when is_map(m) do
    m
  end

  def parse_entry(l) when is_list(l) do
    l |> Map.new() |> parse_entry()
  end
end

a = [title: "Labels", resource: PaxDemoWeb.Admin.LabelResource]
b = %{title: "Labels", resource: PaxDemoWeb.Admin.LabelResource}

m1 = [a, a, a, a, a, a, a, a, a, a]
m2 = [b, b, b, b, b, b, b, b, b, b]
m3 = [a, b, a, b, a, b, a, b, a, b]

Benchee.run(%{
  "kw_list" => fn -> Parse.parse_list(m1) end,
  "map_list" => fn -> Parse.parse_list(m2) end,
  "mixed_list" => fn -> Parse.parse_list(m3) end
})
