#Density Map

library(devtools)
#install_github("nicolasturaro/mapIT")

library(mapIT)
library(readxl)

#density <- data.frame(
#  Region = c("Abruzzo","Basilicata","Calabria","Campania",
#            "Emilia-Romagna","Friuli-Venezia Giulia","Lazio",
#           "Liguria","Lombardia","Marche","Molise","Piemonte",
#          "Puglia","Sardegna","Sicilia","Toscana",
#           "Trentino-Alto Adige","Umbria","Valle d'Aosta","Veneto"),
#Densità = c(30, 81, 67, 55, 33, 43, 77, 63, 35, 45, 45, 32, 58, 70, 57, 43, 41, 65, 93, 32)
#)


density <- data.frame(
  Region = c("Abruzzo","Basilicata","Calabria","Campania",
             "Emilia-Romagna","Friuli-Venezia Giulia","Lazio",
             "Liguria","Lombardia","Marche","Molise","Piemonte",
             "Puglia","Sardegna","Sicilia","Toscana",
             "Trentino-Alto Adige","Umbria","Valle d'Aosta","Veneto"),
  Densità = c(8.970276008, 10.20408163, 9.6022499, 8.672960319, 7.192369216,
              7.640638119, 9.782505461, 9.469387755, 7.120661505, 8.506195183,
              8.695652174, 6.537864413, 10.04046535, 10.09174312, 9.49017199,
              8.101023018, 6.124314442, 8.825816485, 12.5, 6.33628833))


mapIT(Densità, Region, data=density, guide.label="Density ofnZombies")

gp <- list(guide.label="Density \nPDFs")#, low="#fff0f0" , high="red3")

mapIT(Densità, Region, data=density, graphPar=gp)


density <- data.frame(
  Region = c("Abruzzo","Basilicata","Calabria","Campania",
             "Emilia-Romagna","Friuli-Venezia Giulia","Lazio",
             "Liguria","Lombardia","Marche","Molise","Piemonte",
             "Puglia","Sardegna","Sicilia","Toscana",
             "Trentino-Alto Adige","Umbria","Valle d'Aosta","Veneto"),
  Densità = c(34.31952663, 33.33333333, 23.43096234, 36.81415929,
              39.86820428, 45.78754579, 38.83495146, 39.22413793,
              36.16863905, 39.27986907, 28, 41.42480211, 33.8790932,
              25.45454545, 27.34627832, 39.38437253, 39.55223881,
              29.95594714, 33.33333333, 40.29051988))


mapIT(Densità, Region, data=density)

gp <- list(guide.label="Density \nPDFs' Failures", low="#fff0f0" , high="red3")

mapIT(Densità, Region, data=density, graphPar=gp)

