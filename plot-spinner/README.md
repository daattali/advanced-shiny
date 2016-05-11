# Show a spinning "loading" animation while a plot is recalculating

When a Shiny plot is recalculating, the plot gets grayed out. This app shows how you can add a spinner wheel on top of the plot while it is recalculating, to make it clear to the user that the plot is reloading. There can be many different ways to achieve a similar result using different combinations of HTML/CSS, this example is just the simplest one I came up with.

The idea is to place a spinner image in the same container as the plot, center it, and give it a below-default z-index. Whenever the plot is recalculting, make the plot's z-index even lower so that the spinner will show.

---

[![Demo](./plot-spinner.gif)](./plot-spinner.gif)