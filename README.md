# Design-Assignment-FullStack_BE

## Overview
This project is a backend database design for an expense sharing application
similar to Splitwise. It supports group-based expense management with
multiple split types and balance tracking.

## Problem Statement
Design a backend system that allows users to:
- Create users and groups
- Add shared expenses
- Split expenses using different methods
- Track who owes whom
- Settle balances

## Features
- User and group management
- Equal, Exact, and Percentage expense splits
- Balance tracking (who owes whom)
- Settlement support

## Database Design
The database consists of the following tables:
- users
- groups
- group_members
- expenses
- expense_splits
- balances
- settlements

## Split Types
- **Equal Split:** Total amount divided equally among participants
- **Exact Split:** User-defined exact amounts
- **Percentage Split:** Amount calculated using percentage contribution

## Balance Simplification
Each user's net balance is calculated as:
