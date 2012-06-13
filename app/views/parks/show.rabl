node(:id){ @park.id }
node(:name){ @park.name }
node(:facilities){ @park.facilities}
node(:address){ @park.address }
node(:hours){ @park.hours }
node(:park_type){ @park.park_type }
node(:acres){ @park.acres.to_f }
node(:restroom){ @park.restroom == "No" ? false : true }
node(:drinking_water){ @park.drinking_water == "No" ? false : true }