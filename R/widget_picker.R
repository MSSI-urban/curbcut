#' Shiny module for a variable picker
#'
#' This function creates a Shiny module that allows users to pick a variable from a
#' list of options, and returns the selected variable as a reactive expression.
#' The list of options can be dynamically updated based on the input data and the
#' user's choices, and options can be disabled based on user input (time).
#' It consists of a dropdown menu with variable options, with the variable
#' explanation text that appears when the user hovers over each option. The menu
#' can be dynamically updated based on the user's input and the data available
#' in \code{var_list}, \code{df}, and \code{time}. The module can also disable
#' certain options based on the `time` argument, for example if the user is
#' comparing multiple years and some variables are not present in all years.
#'
#' @param id <`character`> The ID of the page in which the widget will appear,
#' e.g. `canale`.
#' @param r <`reactiveValues`> The reactive values shared between modules and
#' pages. Created in the `server.R` file. The output of \code{\link{r_init}}.
#' @param picker_id <`character`> A character string giving the identifier for
#' the picker input object. This will be used as the input's `inputId` and will
#' inform the bookmarking. It needs to be unique in the page. The default value
#' is `"var"`.
#' @param var_list <`named list`> Choices to display in the picker input. Normally
#' made using \code{\link{dropdown_make}}.
#' @param time <`reactive numeric vector`> Vector of time values to use for
#' appending a time to the variables picked. The returned vector will be the
#' same length as this argument.
#' @param ... Additional arguments to pass to \code{\link[shinyWidgets]{updatePickerInput}}
#'
#' @return A reactive expression that returns the selected variable with `time`
#' appended. The length of the output is the same length as the `time` argument.
#' @seealso \code{\link{picker_UI}}
#' @export
picker_server <- function(id, r, picker_id = "var", var_list,
                          time = shiny::reactive(NULL), ...) {
  stopifnot(shiny::is.reactive(time))
  stopifnot(!shiny::is.reactive(var_list))

  shiny::moduleServer(id, function(input, output, session) {
    # Fails if `var_list` isn't a list.
    if (!is.list(var_list)) stop("`var_list` must be a list.")

    # Reformat the picker_id to make it obvious it's a picker (for bookmark)
    picker_id <- paste0("ccpicker_", picker_id)

    # Translate var_list
    var_list_t <- shiny::reactive(cc_t(var_list, lang = r$lang()))

    # Get the `divs` with the explanation on hover (translated)
    hovers <- shiny::reactive(picker_hover_divs(
      var_list = var_list_t(),
      lang = r$lang()
    ))

    # If the picking is made while in a `delta` mode (comparing two years),
    # we disable the variables that are not present at all years.
    multi_year <- shiny::reactiveVal(FALSE)
    # Make sure we don't create unwanted reactivity that triggers the reset
    # of the dropdown.
    shiny::observeEvent(time(), multi_year(length(time()) > 1))
    disable <- shiny::reactive(picker_multi_year_disable(
      var_list = var_list,
      disable = multi_year()
    ))

    # Style the disable (dark gray for the unpickable)
    disable_style <- shiny::reactive({
      sapply(disable(), ifelse, "color: rgba(119, 119, 119, 0.5);", "")
    })

    # Update dropdown menu if there are disabled choices
    shiny::observe({
      shinyWidgets::updatePickerInput(
        session = session,
        inputId = picker_id,
        choices = var_list_t(),
        choicesOpt = c(
          if (!is.null(hovers())) hovers(),
          list(
            disabled = disable(),
            style = disable_style()
          )
        ),
        ...
      )
    })

    # Append the `time`
    var <- shiny::reactive(picker_return_var(
      input = input[[picker_id]],
      time = time()
    ))

    # Return the picked variable as a reactive
    return(var)
  })
}

#' Create a picker input control in an optionally styled div
#'
#' This function creates a \code{\link[shinyWidgets]{pickerInput}} control in a
#' `div` container. The `pickerInput` control allows users to select one item
#' from a list of variables choices.
#'
#' @param id <`character`> The ID of the page in which the widget will appear,
#' e.g. `canale`.
#' @param picker_id <`character`> string giving the identifier for the picker input
#' object. This will be used as the input's `inputId` and will inform the bookmarking.
#' It needs to be unique in the page. The default value is `"var"`.
#' @param var_list <`character vector`> Choices to display in the picker input.
#' Normally made using \code{\link{dropdown_make}}.
#' @param label A character string giving the label for the picker input control.
#' If `NULL`, no label will be displayed.
#' @param width <`character`> A character string giving the width of the picker
#' input control. The width of the input : 'auto', 'fit', '100px', '75%'.
#' @param div_style <`character`> CSS styles to apply to the `div` container.
#' The default value is `NULL` for no additional styling.
#' @param selected A character vector of a value to preselect. The default value
#' is `NULL` (the first value will be selected).
#' @param ... Additional arguments to pass to \code{\link[shinyWidgets]{pickerInput}}
#'
#' @return A `div` container containing a \code{\link[shinyWidgets]{pickerInput}}
#' control.
#' @seealso \code{\link{picker_server}}
#' @export
picker_UI <- function(id, picker_id = "var", var_list, label = NULL,
                      width = "100%", div_style = NULL, selected = NULL,
                      ...) {
  # Verify if the widget ID will interfere with bookmark
  picker_id <- widget_id_verif(widget_id = picker_id)

  # Reformat the picker_id to make it obvious it's a picker (for bookmark)
  picker_id <- paste0("ccpicker_", picker_id)

  # Non-numeric to not interfere with bookmark
  if (is.numeric(var_list)) {
    stop("A picker should not be numeric. It will interfere with bookmarking.")
  }

  # Declare the input in an optionally styled div
  shiny::div(
    style = div_style,
    shinyWidgets::pickerInput(
      inputId = shiny::NS(id, picker_id),
      label = label,
      choices = var_list,
      selected = selected,
      width = width,
      choicesOpt = picker_hover_divs(var_list),
      options = pickerOptions(dropdownAlignRight = "auto"),
      ...
    )
  )
}
