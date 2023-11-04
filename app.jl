import Dash
import ./layout
import ./callbacks
import DashBootstrapComponents as Dbc

app = Dash.dash()
app.config.external_stylesheets = ["Dbc.themes.BOOTSTRAP"]
app.layout = layout.create_layout()
app.callback = callbacks.callback!(app=app)

Dash.run_server(app, "0.0.0.0", debug=true)