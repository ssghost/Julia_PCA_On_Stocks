module components

import Dash
import Dates

export ticker_field = [Dash.html_label("Enter Ticker Symbols:"), 
    Dash.dcc_input(id="ticker-input", type="text")]

export component_field = [Dash.html_label("Select Number of Components:"), 
    Dash.dcc_dropdown(id="component-dropdown", options=[{"label": i, "value": i} for i in range(1, 6)], value=3)]

export datepicker_field = [Dash.html_label("Select Date Range:"),
    Dash.dcc_datepickerrange(id="date-picker", start_date=Dates.now() - Dates.Year(3), end_date=Dates.now(), display_format="YYYY-MM-DD",)]

export submit = [Dash.html_button("Submit", id="submit-button")]

end