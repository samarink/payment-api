# Payment API

- [Running The App](#running-the-app)
- [Routes Overview](#routes-overview)
- [Routes Specification](#routes-specification)
  - [Transactions](#transactions-routes)
  - [Users](#users-routes)

## Running The App

Clone and the seed the app

```bash
git clone https://github.com/samarink/payment-api
cd payment-api
bin/rails db:setup
```

Start the server (port 3000)

```bash
bin/rails s
```

Run unit tests

```bash
bin/rails test
```

or

```bash
bin/rails test --verbose
```

## Routes Overview

### Users

|  Verb  | Path          | Description        |
| :----: | :------------ | ------------------ |
|  GET   | /api/users    | get all users      |
|  POST  | /api/users    | create new user    |
|  GET   | /api/user/:id | view single user   |
| PATCH  | /api/user/:id | modify single user |
|  PUT   | /api/user/:id | modify single user |
| DELETE | /api/user/:id | delete single user |

### Transactions

|  Verb  | Path                                               | Description                                                          |
| :----: | :------------------------------------------------- | -------------------------------------------------------------------- |
|  GET   | /api/users/:user_id/transactions                   | get all transactions belonging to the a single user                  |
|  GET   | /api/users/:user_id/transactions?from=date&to=date | get all transactions belonging to the a single user filtered by date |
|  POST  | /api/users/:user_id/transaction                    | create new transaction belonging to a single user                    |
| PATCH  | /api/transactions/:id                              | modify single transaction                                            |
|  PUT   | /api/transactions/:id                              | modify single transaction                                            |
| DELETE | /api/transactiosы/:id                              | delete single transaction                                            |

## Routes specification

---

## Transactions Routes

Transaction entity

```
date: date
amount: integer (in cents)
name: string
user_id: integer
```

### Request

`GET /api/user/:user_id/transasctions`

### Response

```
[
    {
      ...transaction
    },
    ...
]
```

---
### Request
`GET /api/users/:user_id/transactions?from=date&to=date`

date might be one of the following: '2022-05-12', 'Apr2022'

### Response
```
{
   "balance_at_start_of_the_period": "10",
   "balance_at_end_of_the_period": "50",
   "transactions": [
     {
        ...transaction
     },
      ...more transactions
   ]
}

```

### Request

`POST /api/users/:user_id/transactions`

### Format

`name: string` (required)
`date: string` (required) e.g '2022-05-5'
`amount: integer` (required)

_Note_: You have to nest your attributes under a transaction key

```
{
  "transaction": {
    ...atributes
  }
}
```

### Response

Created transaction or list of errors otherwise

### Request

`PUT /api/transactions/:id`

`PATCH /api/transactions/:id`

### Format

One or more attrubutes to modify

### Reponse

Newly updated transaction

---

### Request

`DELETE /api/transactions/:id`

### Response

`STATUS: 204`

## User Routes

User entity

```
id: integer
name: string
```

### Request

`GET /api/users`

### Response

Returns list of the users

```
[
  {
    ...user
  },
  ...more users
]
```

---

### Request

`POST /api/users`

### Format

`name: string` (required)

_Note_: You have to nest your attributes under a user key

```json
{
  "user": {
    "name": "name"
  }
}
```

### Response

Created user or list of errors otherwise

---

### Request

`GET /api/users/:id`

### Response

User with given id

---

### Request

`PUT /api/users/:id`

`PATCH /api/users/:id`

### Format

One or more attrubutes to modify

```json
{
  "user": {
    "name": "new name"
  }
}
```

### Reponse

Newly updated user

---

### Request

`DELETE /api/users/:id`

### Response

`STATUS: 204`
