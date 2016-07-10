# DSS - EDA - Week 1 - Assignment

## R and PNG files
In this repo there are  4 R files : plot1.R plot2.Rplot3.R and plot4.R . There are also 4 PNG files : plot1.png plot2.png plot3.png and plot4.png. 
The execution of the 4 R files need the **household_power_consumption.txt** in the current directory to be executed. They can be executed all in a batch with the following R command :
```
source( "./plot1.R")
source( "./plot2.R")
source( "./plot3.R")
source( "./plot4.R")
```
And the output will be the 4 PNG files in the current directory. All the objects (data frames and variables) created for the calculation will be removed.
## Memory calculation
> The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).

Reckoning with 4 Bytes for a numeric field and a simplification that all columns are numeric 
```
=> 4 Bytes * 9 columns * 2,075,259 lines = 75 Mega
```

The text file is 123 Mega, so it's maybe too much simplification 

If we use 20 Bytes for the Date column (01/01/2001 => 10 char of 2 Bytes/char) and 16 Bytes for the Time column (01:01:01 => 8 char of 2 Bytes/char) :
```
20 Bytes + 16 Bytes + 7 numeric columns * 4 Bytes = 64 * 2,075,529 lines
> 64 * 2075529
[1] 132833856 ## 133 Mega

```

```
> hpc <- fread( input = "household_power_consumption.txt", na.strings = "?")
> object.size(hpc)
149,582,752 bytes
```
```
> hpc <- fread( input = "household_power_consumption.txt", na.strings = "?", stringsAsFactors = TRUE)
> object.size(hpc)
133,004,464 bytes
```
```
> hpc <- read.csv( file = "household_power_consumption.txt", na.strings = "?", stringsAsFactors = FALSE, sep = ";")
> object.size(hpc)
149,581,752 bytes
```
```
> hpc <- read.csv( file = "household_power_consumption.txt", na.strings = "?", stringsAsFactors = TRUE, sep = ";")
> object.size(hpc)
133,003,464 bytes
```
So what I can say after that is fread is much more efficient in loading time: a couple of seconds vs around 20 sec. In term of memory it's about the same and what was reckoned. With a subtle improvment with factors. 

So, I have 8G RAM on my laptop and with this configuration I don’t really care about a few hundreds Megs, even if I load the file a few times. 

If I have memory issues with really big files I can use the **select** arg in fread  to select only a few columns. 

Or I would subset the number of lines to load with a SQL R package, or from SQL Database, or do some grep/awk pre processing on Linux. 
