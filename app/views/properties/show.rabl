node(:address){ @property.address }
node(:href){ "http://www.madisonapis.com/properties/"+@property.parcel_number+".json"}
node(:city_href){ "http://"+@property.uri.host+@property.uri.request_uri }
node(:parcel_number){ @property.parcel_number }
node(:property_use){ @property.property_use.strip } 
node(:property_class){ @property.property_class }
node(:lot_size){ @property.lot_size.strip.gsub(",", "").to_i }
node(:year_built){ @property.year_built.to_i }
node(:total_living_area){ @property.total_living_area.strip.gsub(",", "").to_i}