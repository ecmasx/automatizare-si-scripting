# IW02 - Currency Exchange Rate API Client

A Python script that interacts with a currency exchange rate API service to fetch and store exchange rate data between different currencies on specific dates.

## Features

- Fetch exchange rates between any two supported currencies on a specific date
- Save exchange rate data in JSON format with descriptive filenames
- Automatic creation of data directory for storing results
- Comprehensive error handling and logging
- Validates date ranges (2025-01-01 to 2025-09-15)
- Command-line interface with helpful arguments
- Logs all operations and errors to `error.log`

## Supported Currencies

- MDL (Moldovan Leu) - default currency
- USD (US Dollar)
- EUR (Euro)
- RON (Romanian Leu)
- RUS (Russian Ruble)
- UAH (Ukrainian Hryvnia)

## Prerequisites

Before running the script, ensure you have:

1. **Python 3.7 or higher** installed on your system
2. **Docker and Docker Compose** installed (for running the API service)
3. The API service running at `http://localhost:8080`

## Installation

### 1. Install Python Dependencies

Navigate to the IW02 directory and install the required Python packages:

```bash
cd IW02
pip3 install -r requirements.txt
```

Or install the required package directly:

```bash
pip3 install requests==2.31.0
```

### 2. Start the API Service

The script requires the currency exchange rate API service to be running. Navigate to the API service directory and start it:

```bash
cd /path/to/lab02prep
cp sample.env .env
docker-compose up -d
```

Verify the service is running:

```bash
docker-compose ps
```

You should see the `php_apache` container running on port 8080.

## Usage

### Basic Usage

The script requires three positional arguments:

```bash
python3 currency_exchange_rate.py <from_currency> <to_currency> <date>
```

**Arguments:**

- `from_currency`: Source currency code (e.g., USD, EUR, MDL)
- `to_currency`: Target currency code (e.g., USD, EUR, MDL)
- `date`: Date in YYYY-MM-DD format (must be between 2025-01-01 and 2025-09-15)

### Examples

1. **Get USD to EUR exchange rate on January 15, 2025:**

   ```bash
   python3 currency_exchange_rate.py USD EUR 2025-01-15
   ```

2. **Get MDL to USD exchange rate on March 5, 2025:**

   ```bash
   python3 currency_exchange_rate.py MDL USD 2025-03-05
   ```

3. **Get EUR to RON exchange rate on April 25, 2025:**

   ```bash
   python3 currency_exchange_rate.py EUR RON 2025-04-25
   ```

4. **List available currencies:**

   ```bash
   python3 currency_exchange_rate.py --list-currencies USD EUR 2025-01-01
   ```

5. **Use custom API URL and key:**
   ```bash
   python3 currency_exchange_rate.py --url http://localhost:8080 --key YOUR_API_KEY USD EUR 2025-01-15
   ```

### Optional Arguments

- `--url`: Specify custom API base URL (default: `http://localhost:8080`)
- `--key`: Specify custom API key (default: `EXAMPLE_API_KEY`)
- `--list-currencies`: List all available currencies and exit
- `--help`: Display help message with all available options

### Output

When successful, the script will:

1. Display the exchange rate information in the console
2. Save the data to a JSON file in the `data/` directory
3. Log all operations to `error.log`

**Example output:**

```
2025-10-02 14:18:49,836 - INFO - Requesting exchange rate: USD -> EUR on 2025-01-15
2025-10-02 14:18:49,857 - INFO - Successfully retrieved exchange rate

============================================================
Exchange Rate Information
============================================================
From:     USD
To:       EUR
Rate:     1.025501
Date:     2025-01-15
============================================================

2025-10-02 14:18:49,857 - INFO - Data saved successfully to: data/exchange_rate_USD_EUR_2025-01-15.json
✓ Data saved to: data/exchange_rate_USD_EUR_2025-01-15.json
```

## Script Structure

### Main Components

#### 1. `CurrencyExchangeClient` Class

The main class that handles all API interactions and file operations.

**Key Methods:**

- **`__init__(base_url, api_key)`**: Initializes the client with API configuration, sets up logging, and creates the data directory.

- **`setup_logging()`**: Configures the logging system to write to both console and `error.log` file with timestamps and log levels.

- **`setup_data_directory()`**: Creates the `data/` directory if it doesn't exist for storing JSON output files.

- **`validate_date(date_str)`**: Validates that the provided date is in the correct format (YYYY-MM-DD) and falls within the valid range (2025-01-01 to 2025-09-15).

- **`get_exchange_rate(from_currency, to_currency, date)`**: Makes a POST request to the API service to fetch the exchange rate between two currencies on a specific date. Handles various exceptions including connection errors, timeouts, HTTP errors, and invalid JSON responses.

- **`save_to_file(data, from_currency, to_currency, date)`**: Saves the API response data to a JSON file with a descriptive filename format: `exchange_rate_{FROM}_{TO}_{DATE}.json` in the `data/` directory.

- **`get_available_currencies()`**: Fetches the list of available currencies from the API service.

#### 2. `main()` Function

The entry point of the script that:

- Parses command-line arguments using `argparse`
- Creates an instance of `CurrencyExchangeClient`
- Handles the `--list-currencies` option
- Calls the appropriate methods to fetch and save exchange rate data
- Displays results to the user and handles exit codes

### Program Flow

1. **Initialization**:

   - Parse command-line arguments
   - Create API client instance
   - Set up logging and data directory

2. **Validation**:

   - Validate date format and range
   - Validate currency codes (handled by API)

3. **API Request**:

   - Make POST request to API with query parameters and authentication
   - Handle network and API errors gracefully

4. **Data Processing**:

   - Parse JSON response
   - Extract exchange rate information
   - Display formatted output to console

5. **File Operations**:

   - Generate filename based on currencies and date
   - Save complete API response to JSON file
   - Log success or failure

6. **Error Handling**:
   - All errors are logged to `error.log` with timestamps
   - User-friendly error messages displayed in console
   - Appropriate exit codes returned (0 for success, 1 for failure)

### Error Handling

The script implements comprehensive error handling for:

- **Connection Errors**: When the API service is not reachable
- **Timeout Errors**: When requests take too long to complete
- **HTTP Errors**: When the API returns error status codes
- **Invalid JSON**: When the API response cannot be parsed
- **Invalid Date Format**: When the date is not in YYYY-MM-DD format
- **Date Out of Range**: When the date is outside 2025-01-01 to 2025-09-15
- **File I/O Errors**: When saving data to files fails
- **API Errors**: When the API returns an error message in the response

All errors are logged to `error.log` with timestamps and detailed messages.

### File Organization

```
IW02/
├── currency_exchange_rate.py    # Main script file
├── requirements.txt              # Python dependencies
├── README.md                     # This documentation
├── error.log                     # Log file (created on first run)
└── data/                         # Directory for JSON output files (created on first run)
    ├── exchange_rate_USD_EUR_2025-01-15.json
    ├── exchange_rate_MDL_USD_2025-03-05.json
    ├── exchange_rate_EUR_RON_2025-04-25.json
    ├── exchange_rate_USD_MDL_2025-06-15.json
    └── exchange_rate_RON_UAH_2025-08-05.json
```

## Testing Results

The script was tested with 5 different dates spanning the valid range with equal intervals:

| Test # | From | To  | Date       | Status | Rate      |
| ------ | ---- | --- | ---------- | ------ | --------- |
| 1      | USD  | EUR | 2025-01-15 | ✓ Pass | 1.025501  |
| 2      | MDL  | USD | 2025-03-05 | ✓ Pass | 18.444900 |
| 3      | EUR  | RON | 2025-04-25 | ✓ Pass | 0.200920  |
| 4      | USD  | MDL | 2025-06-15 | ✓ Pass | 0.059001  |
| 5      | RON  | UAH | 2025-08-05 | ✓ Pass | 0.104916  |

**Error Handling Test:**

- Tested with invalid date (2025-12-25): ✓ Correctly rejected and logged error

All tests passed successfully. JSON files were created in the `data/` directory with proper formatting, and all operations were logged to `error.log`.

## Troubleshooting

### API Service Not Running

**Error**: `Connection Error: Unable to connect to the API service.`

**Solution**: Make sure the Docker service is running:

```bash
cd /path/to/lab02prep
docker-compose up -d
```

### Invalid Date Range

**Error**: `Date YYYY-MM-DD is outside the valid range`

**Solution**: Use a date between 2025-01-01 and 2025-09-15.

### Module Not Found

**Error**: `ModuleNotFoundError: No module named 'requests'`

**Solution**: Install the required dependencies:

```bash
pip3 install -r requirements.txt
```

### Permission Denied

**Error**: `PermissionError: [Errno 13] Permission denied: 'data'`

**Solution**: Ensure you have write permissions in the script directory.

## Dependencies

- **requests** (2.31.0): HTTP library for making API requests
- **Python Standard Library**:
  - `argparse`: Command-line argument parsing
  - `json`: JSON data handling
  - `os`: File system operations
  - `sys`: System-specific parameters and functions
  - `datetime`: Date validation
  - `logging`: Error and operation logging

## License

This project is created for educational purposes as part of the "Automatizare si scripting" course.

## Author

Created for IW02 (Individual Work 02) assignment.
