# Random ETF Experiment

This repository contains a project that explores the possibility of outperforming the S&P 500 by creating random ETFs from a list of all publicly traded companies in the U.S. The goal was to test whether a random selection of stocks could outperform the market and identify any patterns in the results.

## Overview

Exchange-Traded Funds (ETFs) offer diversification by tracking a basket of securities, such as stocks or bonds. The most popular ETF, the SPDR S&P 500 ETF Trust (Ticker: SPY), tracks the 500 largest U.S. companies, offering a benchmark for market performance.

I wanted to test whether it's possible to beat the S&P 500 by randomly creating a set of ETFs. The results of this experiment could offer insight into whether pure chance can outperform carefully constructed portfolios.

## Methodology

### Data Collection

I began by downloading a dataset of all listed companies in the U.S. from the [Nasdaq Stock Screener](https://www.nasdaq.com/). After cleaning the data (removing Special Purpose Acquisition Companies (SPACs) and business services companies), I generated a list of viable companies to use in constructing random ETFs.

### Random ETF Generation

I created an algorithm that randomly selected companies to form 100 distinct ETFs. Each ETF contained between 62 and 81 companies. The returns of these ETFs were then measured over the period from January 1, 2016, to July 1, 2021.

### Results

Out of the 100 random ETFs generated:
- Nine outperformed the S&P 500 in annualized return.
- Two had higher risk-adjusted returns (Sharpe ratio).
- Twenty-nine ETFs lost money.

The S&P 500 had an annualized return of 15.8%, volatility of 18.6%, and a Sharpe ratio of 0.771 over the observed period.

### Best Performing ETF

The best-performing ETF in the experiment was ETF #75, with:
- **Annualized return**: 19.0%
- **Annualized volatility**: 20.6%
- **Sharpe ratio**: 0.852

This ETF had 73 tickers, with some of the top performers including:
- **Pro-Dex Inc. (PDEX)**: 12x return
- **Intrusion (INTZ)**: 9x return
- **Fortinet (FTNT)**: 8.5x return

However, it also contained significant underperformers like:
- **Manycore Tech Inc. (THMO)**: 16x loss
- **Rite Aid (RAD)**: 11x loss

### Conclusion

While the random ETF did outperform the market in this specific time frame, the results highlight that past performance is no guarantee of future success. In the coming weeks, I plan to explore portfolio optimization strategies to improve the chances of long-term success for these ETFs. But for now, the experiment underscores the surprising potential of randomness in investing.

## Code and Data

All code for the analysis is written in R and is available in the repository. The data used for the experiment is sourced from [Yahoo Finance](https://finance.yahoo.com/).

You can replicate the experiment by following the steps below.

## Getting Started

### Prerequisites

To run the code and replicate the experiment, you'll need the following:

- **R** (version 4.0 or higher)
- **RStudio** (recommended for easy script execution)
- **Required R packages** (these are listed in the R script)

### Installing

1. Clone the repository:

   ```bash
     git clone https://github.com/jackhanderson/Random-ETF.git
   ```

2. Navigate to the project directory:

  ```bash
    cd Random-ETF
  ```

3. Open the R notebook in RStudio and run the code to generate your own random ETFs and analyze the results.

