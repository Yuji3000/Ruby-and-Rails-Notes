- To import pandas
``` Python
import pandas as pd
```

- Assign and read from a csv file
``` Python
repair = pd.read_csv('repair.csv')
```
- display first 5 rows of data
``` Python
  repair.head()
```

- display datatypes of the dataset
``` Python
repair.dtypes
```

- creating a dictionary
``` Python
country_data = {
    'nld': 21423,
    'gbr': 18576,
    'deu': 7427
}
```
- show info for columns
``` Python
repair['country'].describe()
```

.append() #add to end of list

type(variable_name) #checks type 

.value_counts()

normalize=True, which will return percentages instead of raw numbers
ascending=True, which will sort from smallest to largest, instead of largest to smallest

# Python Pandas & Jupyter Notes

| **Topic**                           | **Description**                                       | **Code**                                                                                           |
|-------------------------------------|-------------------------------------------------------|----------------------------------------------------------------------------------------------------|
| **Importing Pandas**                | Import the Pandas library                             | `import pandas as pd`                                                                               |
| **Reading from a CSV File**         | Assign and read data from a CSV file                  | `repair = pd.read_csv('repair.csv')`                                                                |
| **Display First 5 Rows**            | Display the first 5 rows of the dataset               | `repair.head()`                                                                                     |
| **Display Data Types**              | Show data types of the dataset                        | `repair.dtypes`                                                                                     |
| **Creating a Dictionary**           | Create a dictionary with country data                 | ```python<br>country_data = {'nld': 21423, 'gbr': 18576, 'deu': 7427}```                            |
| **Describing Data**                 | Get summary info for a specific column (e.g., country)| `repair['country'].describe()`                                                                      |
| **Append to List**                  | Add an item to the end of a list                      | `list_name.append(item)`                                                                            |
| **Check Data Type**                 | Check the data type of a variable                     | `type(variable_name)`                                                                               |
| **Value Counts**                    | Get the count of unique values in a column            | `repair['country'].value_counts()`                                                                  |
| **Options for Value Counts**        | - `normalize=True`: Get percentages <br> - `ascending=True`: Sort from smallest to largest | `repair['country'].value_counts(normalize=True, ascending=True)`|

