import pandas as pd
import numpy as np
from faker import Faker

# Initialize Faker
fake = Faker()

# Number of records to generate
num_records = 1200

# Generate 20 unique department records
def generate_20_unique_departments():
    department_names = [
        "Finance", "Customer Service", "Human Resources", "IT (Information Technology)",
        "Compliance", "Marketing", "Sales", "Loan Department", "Mortgage Department",
        "Investment Banking", "Risk Management", "Operations", "Treasury", "Legal", "Audit",
        "Corporate Banking", "Retail Banking", "Wealth Management", "Credit Department",
        "Accounts Department"
    ]
    
    data = {
        "DepartmentID": [i for i in range(1, 21)],
        "DepartmentName": department_names,
        "ManagerID": [i for i in range(1, 21)],  # Assuming each department has a unique manager
        "Budget": [round(fake.pydecimal(left_digits=8, right_digits=2, positive=True), 2) for _ in range(20)],
        "EstablishedDate": [fake.date_this_century() for _ in range(20)],
        "LastReviewDate": [fake.date_this_year() for _ in range(20)],
    }
    return pd.DataFrame(data)

# Generate and save 20 unique department records
unique_department_data_20 = generate_20_unique_departments()
unique_department_data_20.to_csv('/mnt/data/unique_department_data_20.csv', index=False)
unique_department_sql_20 = generate_sql_insert_statements("Department", unique_department_data_20)
save_sql_to_file('/mnt/data/unique_department_data_20.sql', unique_department_sql_20)

# Adjust Employee Data
def generate_adjusted_employee_data(num_records, department_ids):
    data = {
        "EmployeeID": [i for i in range(1, num_records + 1)],
        "DateOfBirth": [fake.date_of_birth(minimum_age=18, maximum_age=65) for _ in range(num_records)],
        "HireDate": [fake.date_this_decade() for _ in range(num_records)],
        "Position": [fake.job() for _ in range(num_records)],
        "DepartmentID": np.random.choice(department_ids, num_records),
        "FirstName": [fake.first_name() for _ in range(num_records)],
        "LastName": [fake.last_name() for _ in range(num_records)],
        "ManagedByDepartmentID": np.random.choice(department_ids, num_records),
    }
    return pd.DataFrame(data)

# Generate adjusted employee data
adjusted_employee_data = generate_adjusted_employee_data(num_records, unique_department_data_20["DepartmentID"])
adjusted_employee_data.to_csv('/mnt/data/adjusted_employee_data.csv', index=False)
adjusted_employee_sql = generate_sql_insert_statements("Employee", adjusted_employee_data)
save_sql_to_file('/mnt/data/adjusted_employee_data.sql', adjusted_employee_sql)

# Adjust Project Data
def generate_adjusted_project_data(num_records, department_ids, employee_ids):
    data = {
        "ProjectID": [i for i in range(1, num_records + 1)],
        "ProjectName": [fake.catch_phrase() for _ in range(num_records)],
        "StartDate": [fake.date_this_decade() for _ in range(num_records)],
        "EndDate": [fake.date_this_decade() if fake.boolean(chance_of_getting_true=50) else None for _ in range(num_records)],
        "Budget": [round(fake.pydecimal(left_digits=8, right_digits=2, positive=True), 2) for _ in range(num_records)],
        "DepartmentID": np.random.choice(department_ids, num_records),
        "ManagerID": np.random.choice(employee_ids, num_records),
    }
    return pd.DataFrame(data)

# Generate adjusted project data
adjusted_project_data = generate_adjusted_project_data(num_records, unique_department_data_20["DepartmentID"], adjusted_employee_data["EmployeeID"])
adjusted_project_data.to_csv('/mnt/data/adjusted_project_data.csv', index=False)
adjusted_project_sql = generate_sql_insert_statements("Project", adjusted_project_data)
save_sql_to_file('/mnt/data/adjusted_project_data.sql', adjusted_project_sql)

# Function to generate SQL insert statements from a DataFrame
def generate_sql_insert_statements(table_name, dataframe):
    insert_statements = []
    columns = ", ".join(dataframe.columns)
    for row in dataframe.itertuples(index=False, name=None):
        values = ", ".join([f"'{str(value)}'" if pd.notna(value) else "NULL" for value in row])
        insert_statement = f"INSERT INTO {table_name} ({columns}) VALUES ({values});"
        insert_statements.append(insert_statement)
    return insert_statements

# Save the SQL insert statements to a file
def save_sql_to_file(filename, sql_statements):
    with open(filename, 'w') as f:
        f.write("\n".join(sql_statements))

# Check for reserved SQL keywords in the Position column and replace them with non-reserved words
def clean_reserved_words_in_positions(dataframe):
    reserved_words = set([
        "ACCESS", "ADD", "ALL", "ALTER", "AND", "ANY", "AS", "ASC", "AUDIT", "BETWEEN", 
        "BY", "CHAR", "CHECK", "CLUSTER", "COLUMN", "COMMENT", "COMPRESS", "CONNECT", 
        "CREATE", "CURRENT", "DATE", "DECIMAL", "DEFAULT", "DELETE", "DESC", "DISTINCT", 
        "DROP", "ELSE", "EXCLUSIVE", "EXISTS", "FILE", "FLOAT", "FOR", "FROM", "GRANT", 
        "GROUP", "HAVING", "IDENTIFIED", "IMMEDIATE", "IN", "INCREMENT", "INDEX", 
        "INITIAL", "INSERT", "INTEGER", "INTERSECT", "INTO", "IS", "LEVEL", "LIKE", 
        "LOCK", "LONG", "MAXEXTENTS", "MINUS", "MLSLABEL", "MODE", "MODIFY", "NOAUDIT", 
        "NOCOMPRESS", "NOT", "NOWAIT", "NULL", "NUMBER", "OF", "OFFLINE", "ON", "ONLINE", 
        "OPTION", "OR", "ORDER", "PCTFREE", "PRIOR", "PRIVILEGES", "PUBLIC", "RAW", 
        "RENAME", "RESOURCE", "REVOKE", "ROW", "ROWID", "ROWNUM", "ROWS", "SELECT", 
        "SESSION", "SET", "SHARE", "SIZE", "SMALLINT", "START", "SUCCESSFUL", "SYNONYM", 
        "SYSDATE", "TABLE", "THEN", "TO", "TRIGGER", "UID", "UNION", "UNIQUE", "UPDATE", 
        "USER", "VALIDATE", "VALUES", "VARCHAR", "VARCHAR2", "VIEW", "WHENEVER", "WHERE", 
        "WITH"
    ])

    # Replace reserved words with non-reserved words
    unique_positions = set(dataframe["Position"])
    replacement_positions = list(unique_positions - reserved_words)
    replacement_positions = (replacement_positions * (len(dataframe) // len(replacement_positions) + 1))[:len(dataframe)]
    
    dataframe["Position"] = replacement_positions
    return dataframe

# Clean the Position column in the adjusted employee data
cleaned_employee_data = clean_reserved_words_in_positions(adjusted_employee_data)

# List of additional reserved words found in the data
additional_reserved_words = {
    "service", "and", "Service fast", "Local", "data", "spatial", "union", 
    "control", "broker", "Grant", "Barrister's clerk"
}

# Function to replace additional reserved words in Position column
def replace_additional_reserved_words(dataframe, reserved_words):
    # Find unique positions in the dataframe
    unique_positions = set(dataframe["Position"])
    
    # Generate a list of replacement positions
    replacement_positions = list(unique_positions - reserved_words)
    replacement_positions = (replacement_positions * (len(dataframe) // len(replacement_positions) + 1))[:len(dataframe)]
    
    # Replace reserved words with non-reserved words
    for reserved_word in reserved_words:
        dataframe.loc[dataframe["Position"] == reserved_word, "Position"] = np.random.choice(replacement_positions)
    
    return dataframe

# Replace additional reserved words in the Position column
cleaned_employee_data = replace_additional_reserved_words(cleaned_employee_data, additional_reserved_words)

# Extract positions from records that do not have reserved words
valid_positions = pd.concat([
    cleaned_employee_data.loc[:214, "Position"],
    cleaned_employee_data.loc[769:, "Position"]
]).unique()

# Replace positions in the cleaned employee data with valid positions
def replace_positions_with_valid(dataframe, valid_positions):
    repeated_positions = list(valid_positions) * (len(dataframe) // len(valid_positions) + 1)
    dataframe["Position"] = repeated_positions[:len(dataframe)]
    return dataframe

# Apply the replacement
final_cleaned_employee_data = replace_positions_with_valid(cleaned_employee_data, valid_positions)

# Save the final cleaned employee data to a CSV file
final_cleaned_employee_data.to_csv('/mnt/data/final_cleaned_employee_data.csv', index=False)

# Generate SQL insert statements for final cleaned employee data
final_cleaned_employee_sql = generate_sql_insert_stat
