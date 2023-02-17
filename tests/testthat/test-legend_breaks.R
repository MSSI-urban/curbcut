test_that("legend_breaks.q5 works", {
  vars1 <- structure(list(var_left = "housing_tenant_2016", var_right = " "),
    class = "q5"
  )
  vars2 <- structure(list(var_left = "housing_value_2011", var_right = " "),
    class = "q5"
  )
  vars3 <- structure(list(var_left = "climate_drought", var_right = " "),
    class = "q5"
  )
  expect_equal(
    legend_breaks(vars1, df = "CMA_CSD"),
    structure(c("0%", "20%", "40%", "60%", "80%", "100%"), chr_breaks = FALSE)
  )
  expect_equal(
    legend_breaks(vars2, df = "CMA_DA"),
    structure(c("$0K", "$200K", "$400K", "$600K", "$800K", "$1,000K"), chr_breaks = FALSE)
  )
  expect_equal(
    legend_breaks(vars3, df = "grid_grid"),
    structure(c(NA, "Insig.", "Minor", "Mod.", "Elev.", "Major"), chr_breaks = TRUE)
  )
})

test_that("legend_breaks.q100 works", {
  vars <- structure(list(var_left = "climate_flood", var_right = " "),
    class = "q100"
  )
  expect_equal(
    legend_breaks(vars),
    list(
      "Low", NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
      "High"
    )
  )
})

test_that("legend_breaks.qual works", {
  vars <- structure(list(var_left = "climate_flood", var_right = " "),
    class = "qual"
  )
  expect_equal(
    legend_breaks(vars, df = "grid_grid"),
    c(NA, "Insig.", "Minor", "Mod.", "Elev.", "Major")
  )
})

# test_that("legend_breaks.bivar_ldelta_rq3 works", {
#   vars <- structure(list(var_left = c("housing_tenant_2006",
#                                       "housing_tenant_2016"),
#                          var_right = "climate_drought_2016"),
#                     class = "bivar_ldelta_rq3")
#   expect_equal(legend_breaks(vars, data = data, region = "CMA", scale = "CT"),
#                #TKTK
#   )
# })

test_that("legend_breaks.delta works", {
  vars <- structure(
    list(var_left = c(
      "housing_tenant_2006",
      "housing_tenant_2016"
    ), var_right = " "),
    class = "delta"
  )
  expect_equal(
    legend_breaks(vars),
    c("-10%", "-2%", "+2%", "+10%")
  )
})

test_that("legend_breaks.bivar works", {
  vars <- structure(
    list(
      var_left = "climate_flood",
      var_right = "housing_tenant_2016"
    ),
    class = "bivar"
  )
  expect_equal(
    legend_breaks(vars, df = "grid_grid"),
    list(x = c("0.2%", "20.2%", "57.1%", "100%"), y = c(
      "0", "1",
      "3", "5"
    ))
  )
})

# test_that("legend_breaks.delta_bivar works", {
#   vars <- structure(list(var_left = c("inc_50_2006", "inc_50_2016"),
#                          var_right = c("housing_tenant_2006",
#                                        "housing_tenant_2016")),
#                     class = "delta_bivar")
#   expect_equal(legend_breaks(vars),
#                list(ggplot2::labs(x = "Tenant (\u0394 2006 - 2016)",
#                                   y = "Inc. <$50k (\u0394 2006 - 2016)"),
#                     x_short = "Tenant",
#                     y_short = "Inc. <$50k"))
# })