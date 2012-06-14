node(:resource_name){ "properties"}
node(:required_parameters) do
  [:house_number, :street_name, :street_type]
end
node(:optional_parameters) do
  [:street_direction, :unit]
end
node(:example){ "http://www.madisonapis.com/properties.json?house_number=2646&street_name=Kendall&street_type=Ave"}