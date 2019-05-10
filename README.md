# Simple Express Server with GraphQL

This is very simple express server ready to use with the integration of graphql.

## Getting Started

Clone repository

```
git clone https://github.com/Rohitturbot/express-graphql.git
```

go to

```
cd ./express-graphql
```

install dependencies

```
npm i
```

run project

```
npm run start
```

# How to Use

It runs on PORT number `8080` so you have to navigate to the `localhost:8080/graphql` to use it. You can run GraphQL queries in the GraphiQL client provided by GraphQL developers.

This have two GraphQL types `UserType` & `PostType`. We have Quires & Mutation builtin to test.

## Example Queries

I'm using [JSONPlaceholder](https://jsonplaceholder.typicode.com/) as my datastore. so you can make use of it.

1. **Get User with specific ID**

```
  user(id:"10"){
    phone
    id
    name
    username
  }
```

2. **Get Post of Specific ID**

```
  post(id:"2"){
    id
    body
    user{
      id
      name

    }
  }
```

## Example Mutations

1. **Add User to the DataStore(DB)**

```
mutation{
  addUser(name:"lalit"){
    id
    name
    phone
  }
}
```

2. **Update/Edit User to the DataStore(DB)**

```
mutation{
  updateUser(id:"10", phone:"8765522803"){
    phone
    id
    name
  }
}
```

3. **Delete User to the DataStore(DB)**

```
mutation{
  delete(id:"10"){
    id
  }
}
```

##Turbot Testing

Github testing for events from codebuild lore