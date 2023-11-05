module layout

import Dash
import DashBootstrapComponents as Dbc
import components as Cpn

export create_layout = Dbc.dbc_container(
    [Dash.html_h1("PCA on Stock Returns"),
    Dbc.dbc_row([Dbc.dbc_col(Cpn.ticker_field)]),
    Dbc.dbc_row([Dbc.dbc_col(Cpn.component_field)]),
    Dbc.dbc_row([Dbc.dbc_col(Cpn.datepicker_field)]),
    Dbc.dbc_row([Dbc.dbc_col(Cpn.submit)]),
    Dbc.dbc_row([Dbc.dbc_col([Dash.dcc_graph(id="bar-chart"), width=4]), Dbc.dbc_col([Dash.dcc_graph(id="line-chart"), width=4])])]
)

end