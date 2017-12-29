
Predicting film gross to maximise revenue and optimise cost for WEC

## Executive Summary   
The general structure of the film industry involves the film distributor who bids and purchases the rights to market a film. The film distributor then sells leases to screen the film to movie theatre operators. 
 
In the film industry, movie theatre operators will share a proportion of ticket sales with the film distributor based on the lease agreement. The ability to negotiate deals with the film distributor depends on the size of the theatre operator, location and other factors. Thus, smaller theatre operators lose out and may suffer in terms of profitability. 
 
In this case, the target audience is WE Cinemas (WEC), a movie theatre operator, who is seeking advice on maximising profits and optimising cost.  
 
By being able to predict the film gross, WEC can give a good estimate of the expected demand for ticket sales for the film, allowing WEC to better gauge the reception the consumers have for the film. This is possible by using easily accessible pre-release information such as the cast actors, genre, movie budget, number of Facebook likes, etc. to predict the film gross. This allows the WEC to maximise profits by estimating the number of days the movie is being screened, the frequency of show times and which film leases to purchase. 

## Data Set
Data set used was taken from https://data.world/popculture/imdb-5000-movie-dataset. Data was scraped from www.the-numbers.com, www.IMDB.com, and a Python library called “scrapy”. 
 
A list of 5043 movies with 28 variables was obtained over a span of 100 years and 66 countries

## Procedure
Linear Regression will be used as the model to predict the gross of each movie due to the predictor variable being continuous in nature. Also, clustering will be explored with the different genres of the movies to possibly improve the performance of the models. 

To evaluate the performance of the analytics model, the Adjusted R2 will be taken into consideration.  
 
The performance of the model will be evaluated by comparing the Adjusted R2 to the baseline model, which in our case would be the linear model of the gross against the most significant variable in our analysis only. Also, all models will be evaluated at a 1% level of significance to ensure that the variance explained by our dataset is accurate. 

## Outcome
All the models that are applied have a p-value of < 2.2 e-16 and this means that for all models, we can reject the Null Hypothesis that the model is not significant and that the given adjusted R2 are accurate as an explanation for its predicted variance. 
 
| Models         | m0     |  m1    |  m2    |  m3.1  |   m3.2 |  m3.3  |
| :-------------:|:------:|:------:|:------:|:------:|:------:|:------:|
| Adjusted R2    | 0.3994 | 0.4307 | 0.4241 | 0.4308 | 0.4374 | 0.3929 |
 
All models except the cluster for Non-Fiction (m3.3) show a higher adjusted R2 as compared to the baseline model (m0). 
 
From the clustering it can be seen that the adjusted R2 for the linear regression of cluster Fiction General(m3.1) and Fiction Mature(m3.2) is higher than the general linear regression (m1) and this means that the higher the percentage of predicted variance is explained by m3.2 and m3.1 as compared to m1.  
 
It is more accurate to use the cluster linear regression for Fiction General and Fiction Mature but not for Non-Fiction. This may be because for Non-Fiction movies, the relative gross is not accurately predicted given the available variables and are determined by other variables not included in the model instead. 
 
