test_that("is_scale_df works", {
  expect_equal(
    is_scale_df(c("CSD", "CT", "DA"), "CMA_DA"),
    TRUE
  )
  expect_equal(
    is_scale_df(c("CSD", "CT", "DA"), "grid_grid"),
    FALSE
  )
})

test_that("s_extract works", {
  expect_equal(
    s_extract("\\d{4}$", "housing_tenant_2016"),
    "2016"
  )
  expect_equal(
    s_extract("\\d{4}$", c("housing_tenant_2016", "housing_tenant_2021")),
    c("2016", "2021")
  )
  expect_equal(
    s_extract("(?<=housing_tenant_).*", "housing_tenant_2016"),
    "2016"
  )
  expect_equal(
    s_extract("^.*?(?=_)", "CMA_DA"),
    "CMA"
  )
})

test_that("var_get_time works", {
  expect_equal(
    var_get_time("housing_tenant_2016"),
    "2016"
  )
  expect_equal(
    var_get_time(c("housing_tenant_2016", "housing_tenant_2021")),
    c("2016", "2021")
  )
})

test_that("var_remove_time works", {
  expect_equal(
    var_remove_time("housing_tenant_2016"),
    "housing_tenant"
  )
  expect_equal(
    var_remove_time(c("housing_tenant_2016", "housing_tenant_2021")),
    "housing_tenant"
  )
})

test_that("var_get_info works", {
  expect_equal(
    var_get_info(
      var = "housing_tenant_2016",
      what = "var_title"
    ),
    "Tenant-occupied (%)"
  )
  expect_equal(
    var_get_info(
      var = c("housing_tenant_2016", "housing_tenant_2021"),
      what = "var_title"
    ),
    "Tenant-occupied (%)"
  )
  expect_equal(
    var_get_info(
      var = "housing_tenant",
      what = "var_title"
    ),
    "Tenant-occupied (%)"
  )
})

test_that("var_get_title works", {
  expect_equal(
    var_get_title(var = "housing_tenant_2016"),
    "Tenant-occupied (%)"
  )
  expect_equal(
    var_get_title(var = c("housing_tenant_2016", "housing_tenant_2021")),
    "Tenant-occupied (%)"
  )
  expect_equal(
    var_get_title(var = "housing_tenant"),
    "Tenant-occupied (%)"
  )
  expect_equal(
    var_get_title(var = "housing_tenant_2016", short_treshold = 12),
    "Tenant"
  )
  expect_equal(
    var_get_title(
      var = c("housing_tenant_2016", "housing_tenant_2021"),
      short_treshold = 12
    ),
    "Tenant"
  )
  expect_equal(
    var_get_title(var = "housing_tenant", short_treshold = 12),
    "Tenant"
  )
})

test_that("var_get_breaks works", {
  expect_equal(
    var_get_breaks(
      var = vars_build("housing_tenant_2016", df = "CMA_CSD")$var_left,
      df = "CMA_CSD", q3_q5 = "q5",
      pretty = TRUE, compact = TRUE
    ),
    c("0%", "20%", "40%", "60%", "80%", "100%")
  )

  expect_equal(
    var_get_breaks(
      var = vars_build("housing_value_2016", df = "CMA_CSD")$var_left,
      df = "CMA_CSD", q3_q5 = "q5",
      pretty = TRUE, compact = TRUE
    ),
    c("$0K", "$200K", "$400K", "$600K", "$800K", "$1,000K")
  )

  # SHOULD CHANGE IN FUTURE VARIABLES.QS -> THE FIRST IS NA, NOT INSIG.
  expect_equal(
    var_get_breaks(
      var = "climate_drought",
      df = "grid_grid", q3_q5 = "q5",
      break_col = "var_name_short",
      pretty = TRUE, compact = TRUE
    ),
    c(NA, "Insig.", "Minor", "Mod.", "Elev.", "Major")
  )
})

test_that("treat_to_DA works", {
  expect_equal(
    treat_to_DA(
      scales_as_DA = c("building", "street"),
      df = "CMA_building"
    ),
    "CMA_DA"
  )

  expect_equal(
    treat_to_DA(
      scales_as_DA = c("building", "street"),
      df = "CMA_DA"
    ),
    "CMA_DA"
  )

  expect_equal(
    treat_to_DA(
      scales_as_DA = c("building", "street"),
      df = "CMA_CSD"
    ),
    "CMA_CSD"
  )
})

test_that("get_from_globalenv works", {
  expect_equal(
    get_from_globalenv("scales_dictionary"),
    structure(list(scale = c(
      "CSD", "CT", "DA", "DB", "building",
      "cmhczone", "centraide", "grid"
    ), sing = c(
      "borough/city", "census tract",
      "dissemination area", "dissemination block", "dissemination area",
      "CMHC zone", "centraide zone", "250-m grid cell"
    ), plur = c(
      "boroughs or cities",
      "census tracts", "dissemination areas", "dissemination blocks",
      "dissemination areas", "CMHC zones", "centraide zones", "250-m grid cells"
    ), slider_title = c(
      "Borough/City", "Census tract", "Dissemination area",
      "Dissemination block", "Building", "CMHC zone", "Centraide zone",
      "250-m"
    ), place_heading = c(
      "{name_2} of {name}", "Census tract {name} ({name_2})",
      "Dissemination area {name} ({name_2})", "Dissemination block {name} ({name_2})",
      "{name}", "CMHC zone of {name}", "Centraide zone of {name}",
      "{name}"
    ), place_name = c(
      "{name}", "Census tract {name}", "Dissemination area {name}",
      "Dissemination block {name}", "The dissemination area around {name}",
      "{name}", "{name}", "250-m grid cell around {name}"
    )), row.names = c(
      NA,
      -8L
    ), class = c("tbl_df", "tbl", "data.frame"))
  )
  expect_error(get_from_globalenv("eso"))
})

test_that("var_row_index works", {
  expect_equal(var_row_index("housing_tenant_2016"), 1)
  expect_equal(var_row_index("housing_tenant"), 1)
  expect_equal(var_row_index("not_there"), "not_there")
  expect_equal(var_row_index(c("housing_rent_2001", "housing_rent_2016")), 2)
  expect_equal(var_row_index(" "), " ")
})

test_that("widget_id_verif returns the original widget ID for a valid widget ID", {
  expect_equal(widget_id_verif("abc"), "abc")
})

test_that("widget_id_verif throws an error when the widget ID contains more than one underscore", {
  expect_error(
    widget_id_verif("a_b_c"),
    "No underscore can be used in a widget ID."
  )
})

test_that("widget_id_verif hrows an error when the widget ID has more than 3 characters", {
  expect_error(
    widget_id_verif("abcd"),
    "Widget ID can contain no more than 4 characters to reduce bookmark URL size."
  )
})

test_that("widget_id_verif throws an error when the widget ID interferes with known codes and short codes", {
  expect_error(widget_id_verif("pi"), "Widget ID can not be the same as a value of `curbcut::bookmark_codes` or `curbcut::bookmark_shorts` to limit interference with bookmark codes.")
})
