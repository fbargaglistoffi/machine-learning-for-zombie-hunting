######################################################################################
##                                                                                  ##
##        Code for Plots for the "Machine Learning for Zombie Hunting" paper        ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

library(plotrix)

pdf <- c(11.44, 11.31, 12.28, 12.26, 11.70, 10.51, 8.94)
gdp_growth <- c(0.707, -2.981, -1.841, -0.005, 0.778, 1.280, 1.716) # Data from World Bank (https://data.worldbank.org/indicator/NY.GDP.MKTP.KD.ZG?end=2018&locations=IT&start=2011)
unemployment <- c(8.4, 10.7, 12.1, 12.7, 11.9, 11.7, 11.2) # Data from Statista (https://www.statista.com/statistics/531010/unemployment-rate-italy/)
years <- c(seq(2011,2017,1))


twoord.plot(years, pdf,
            years, gdp_growth,
            type= c("l", "l"),
            lwd = 3,
            xaxt = 'n', yaxt = 'n',
            lylim=range(zombie)+c(-0.5,0.5),rylim=range(gdp_growth)+c(-0.5,0.5),
            lcol=4,
            xlab = "Year",
            ylab = "PDFs rate",
            rylab = "GDP growth rate",
            main = "Share of Persistently Distressed Firms and GDP growth",
            do.first="plot_bg();grid(col=\"white\",lty=1)")

twoord.plot(years, zombie,
            years, unemployment,
            type= c("l", "l"),
            lwd = 3, 
            xaxt = 'n', yaxt = 'n',
            lylim=range(zombie)+c(-0.5,0.5),rylim=range(unemployment)+c(-0.5,0.5),
            lcol = 4,
            rcol="coral4",
            xlab = "Year",
            ylab = "PDFs rate",
            rylab = "Unemployment rate rate",
            main = "Share of Persistently Distressed Firms and Unemployment Rate",
            do.first="plot_bg();grid(col=\"white\",lty=1)")
