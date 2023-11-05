module callbacks

import Dash
import PlotlyJS as Plt
import YStockData as Ysd 
import MultivariateStats as MStat 

export callback!(
    app,
    [Dash.Output("bar-chart", "figure"),
    Dash.Output("line-chart", "figure")],
    [Dash.Input("submit-button", "n_clicks")],
    [Dash.State("ticker-input", "value"),
    Dash.State("component-dropdown", "value"),
    Dash.State("date-picker", "start_date"),
    Dash.State("date-picker", "end_date")]
) do n_clicks, tickers, n_components, start_date, end_date 
    if not tickers
        return {}, {} end
    tickers = split(tickers, ",")
    data = Ysd.get_historical(tickers, start_date, end_date)
    function pct_change(input::AbstractVector{<:Number})
        res = @view(input[2:end]) ./ @view(input[1:end-1]) .- 1
        [missing; res]
    end
    data = pct_change(data)
    pca = MStat.PCA(n_components=n_components)
    Res = fit(PCA, data)
    bar_chart = Plt.graph_objs.figure(
        data=[Plt.graph_objs.bar(x=["PC" + string(i + 1) for i in range(n_components)], y=Res.principalvars)],
        layout=Plt.graph_objs.layout(title="Principal Variance by Component", xaxis=Dict([title="Principal Component"]), yaxis=Dict([title="Principal Variance"]))
    )
    line_chart = Plt.graph_objs.figure(
        data=[Plt.graph_objs.scatter(x=["PC" + string(i + 1) for i in range(n_components)], y=cumsum(Res.principalvars), mode="lines+markers")],
        layout=Plt.graph_objs.layout(
            title="Cumulative Variance by Components", xaxis=Dict([title="Principal Component"]), yaxis=Dict([title="Cumulative Variance"]),
        )
    )
    end 
end