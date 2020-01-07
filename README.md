# BankingApi

## Environment

Dependencies
---------------------------
 * Docker
 * docker-compose

## Setup
```bash
$ docker-compose build
```

### Runing Test

* Before run test run `docker-compose run web bash` to access the `bash` inside the `web` container.

Once inside  the container run maybe you will need to install all the dependencies by runing `mix deps.get`

Inside on container run the following command
`MIX_ENV=test mix test`

### Running Server
To start your Phoenix server run `docker-compose up`

### Unauthenticated routes

**POST** `localhost:4000/api/v1/signup`

Parameters Example:
```json
{
  "email": "john@email.com", 
  "password": "password",
  "name": "Johnny Doe"
}
```
Response
```json
{
  "id": "1",
  "email": "john@email.com"
}
```
**POST** `localhost:4000/api/v1/signin`

Parameters Example:
```json
{
  "email": "john@email.com",
  "password": "password"
}
```
Response (example)
```json
{
  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJiYW5raW5nX2FwaSIsImV4cCI6MTU4MDgwODMxMiwiaWF0IjoxNTc4Mzg5MTEyLCJpc3MiOiJiYW5raW5nX2FwaSIsImp0aSI6ImZjNDc1YTZkLTEyMjAtNDc1Ni04MWUzLWNhYjY0YzRiY2ZmYSIsIm5iZiI6MTU3ODM4OTExMSwic3ViIjoiMjg0IiwidHlwIjoiYWNjZXNzIn0.Z_vnQ5p7NomBAa3cbHkho1hJEawN0pWwPD0NlTe-6wXHNpU_gcxHsGFBIMZlRWhd7OBl2VA00Z4anSWLKHQwnQ"
}
```
### Authenticated routes


**POST** `localhost:4000/api/v1/withdraw`

Parameters Example:
```json
{
  "amount": 30000
}
```
Response (example)
```json
{
  "account_id": "5eb60246-ede8-4bb4-8c05-9cdb56f170bd",
  "amount": "R$-300.00",
  "date": "2020-01-07T09:43:30",
  "transaction_id": "42",
  "type": "withdraw"
}
```

**POST** `localhost:4000/api/v1/transfer`

Parameters Example:
```json
{
  "account_id": "1",
  "amount": 50000
}
```
Response (example)
Success
```json
{
  "transactions": [
    {
      "account_id": "4",
      "amount": "R$-500.00",
      "date": "2020-01-07T09:25:55",
      "transaction_id": "13123",
      "type": "transfer"
    },
    {
      "account_id": "3",
      "amount": "R$-500.00",
      "date": "2020-01-07T09:25:55",
      "transaction_id": "13124",
      "type": "transfer"
    }
  ]
}
```
### Error
```json
{
  "error": "transaction fail"
}
```
**GET** `localhost:4000/api/v1/report`

Response (example)
```json
{
  "month": {
    "06": [
      {
        "amount": "R$0.10",
        "date": "2020-01-06T04:43:50",
        "transaction_id": 91,
        "user_id": 3
      },
      {
        "amount": "R$0.10",
        "date": "2020-01-06T04:45:41",
        "transaction_id": 96,
        "user_id": 14
      },
      {
        "amount": "R$-0.10",
        "date": "2020-01-06T04:45:41",
        "transaction_id": 97,
        "user_id": 3
      },
      {
        "amount": "R$2.57",
        "date": "2020-01-06T04:46:27",
        "transaction_id": 102,
        "user_id": 14
      },
      {
        "amount": "R$-2.57",
        "date": "2020-01-06T04:46:27",
        "transaction_id": 103,
        "user_id": 3
      },
      {
        "amount": "R$-2.57",
        "date": "2020-01-06T06:04:50",
        "transaction_id": 104,
        "user_id": 14
      },
      {
        "amount": "R$2.57",
        "date": "2020-01-06T06:04:50",
        "transaction_id": 105,
        "user_id": 3
      },
      {
        "amount": "R$2.57",
        "date": "2020-01-06T06:10:41",
        "transaction_id": 108,
        "user_id": 14
      },
      {
        "amount": "R$-2.57",
        "date": "2020-01-06T06:10:41",
        "transaction_id": 109,
        "user_id": 3
      },
      {
        "amount": "R$-2.57",
        "date": "2020-01-06T06:14:34",
        "transaction_id": 112,
        "user_id": 14
      },
      {
        "amount": "R$2.57",
        "date": "2020-01-06T06:14:34",
        "transaction_id": 113,
        "user_id": 3
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-06T06:23:28",
        "transaction_id": 114,
        "user_id": 14
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-06T06:24:59",
        "transaction_id": 115,
        "user_id": 14
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-06T06:25:29",
        "transaction_id": 116,
        "user_id": 14
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-06T06:33:41",
        "transaction_id": 117,
        "user_id": 14
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-06T06:33:59",
        "transaction_id": 120,
        "user_id": 14
      },
      {
        "amount": "R$0.01",
        "date": "2020-01-06T06:33:59",
        "transaction_id": 121,
        "user_id": 3
      }
    ],
    "07": [
      {
        "amount": "R$10.00",
        "date": "2020-01-07T09:24:14",
        "transaction_id": 353,
        "user_id": 284
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-07T09:26:11",
        "transaction_id": 356,
        "user_id": 14
      },
      {
        "amount": "R$10.00",
        "date": "2020-01-07T09:24:01",
        "transaction_id": 352,
        "user_id": 283
      },
      {
        "amount": "R$-0.01",
        "date": "2020-01-07T09:25:55",
        "transaction_id": 354,
        "user_id": 14
      },
      {
        "amount": "R$0.01",
        "date": "2020-01-07T09:25:55",
        "transaction_id": 355,
        "user_id": 283
      }
    ]
  },
  "today": [
    {
      "amount": "R$10.00",
      "date": "2020-01-07T09:24:14",
      "transaction_id": 353,
      "user_id": 284
    },
    {
      "amount": "R$-0.01",
      "date": "2020-01-07T09:26:11",
      "transaction_id": 356,
      "user_id": 14
    },
    {
      "amount": "R$10.00",
      "date": "2020-01-07T09:24:01",
      "transaction_id": 352,
      "user_id": 283
    },
    {
      "amount": "R$-0.01",
      "date": "2020-01-07T09:25:55",
      "transaction_id": 354,
      "user_id": 14
    },
    {
      "amount": "R$0.01",
      "date": "2020-01-07T09:25:55",
      "transaction_id": 355,
      "user_id": 283
    }
  ],
  "year": {
    "01": {
      "06": [
        {
          "amount": "R$0.10",
          "date": "2020-01-06T04:43:50",
          "transaction_id": 91,
          "user_id": 3
        },
        {
          "amount": "R$0.10",
          "date": "2020-01-06T04:45:41",
          "transaction_id": 96,
          "user_id": 14
        },
        {
          "amount": "R$-0.10",
          "date": "2020-01-06T04:45:41",
          "transaction_id": 97,
          "user_id": 3
        },
        {
          "amount": "R$2.57",
          "date": "2020-01-06T04:46:27",
          "transaction_id": 102,
          "user_id": 14
        },
        {
          "amount": "R$-2.57",
          "date": "2020-01-06T04:46:27",
          "transaction_id": 103,
          "user_id": 3
        },
        {
          "amount": "R$-2.57",
          "date": "2020-01-06T06:04:50",
          "transaction_id": 104,
          "user_id": 14
        },
        {
          "amount": "R$2.57",
          "date": "2020-01-06T06:04:50",
          "transaction_id": 105,
          "user_id": 3
        },
        {
          "amount": "R$2.57",
          "date": "2020-01-06T06:10:41",
          "transaction_id": 108,
          "user_id": 14
        },
        {
          "amount": "R$-2.57",
          "date": "2020-01-06T06:10:41",
          "transaction_id": 109,
          "user_id": 3
        },
        {
          "amount": "R$-2.57",
          "date": "2020-01-06T06:14:34",
          "transaction_id": 112,
          "user_id": 14
        },
        {
          "amount": "R$2.57",
          "date": "2020-01-06T06:14:34",
          "transaction_id": 113,
          "user_id": 3
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-06T06:23:28",
          "transaction_id": 114,
          "user_id": 14
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-06T06:24:59",
          "transaction_id": 115,
          "user_id": 14
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-06T06:25:29",
          "transaction_id": 116,
          "user_id": 14
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-06T06:33:41",
          "transaction_id": 117,
          "user_id": 14
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-06T06:33:59",
          "transaction_id": 120,
          "user_id": 14
        },
        {
          "amount": "R$0.01",
          "date": "2020-01-06T06:33:59",
          "transaction_id": 121,
          "user_id": 3
        }
      ],
      "07": [
        {
          "amount": "R$10.00",
          "date": "2020-01-07T09:24:14",
          "transaction_id": 353,
          "user_id": 284
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-07T09:26:11",
          "transaction_id": 356,
          "user_id": 14
        },
        {
          "amount": "R$10.00",
          "date": "2020-01-07T09:24:01",
          "transaction_id": 352,
          "user_id": 283
        },
        {
          "amount": "R$-0.01",
          "date": "2020-01-07T09:25:55",
          "transaction_id": 354,
          "user_id": 14
        },
        {
          "amount": "R$0.01",
          "date": "2020-01-07T09:25:55",
          "transaction_id": 355,
          "user_id": 283
        }
      ]
    }
  }
}
```

### Todo:
  * production deploy