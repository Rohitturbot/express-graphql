const graphql = require("graphql");
// const _ = require("lodash");
const axios = require("axios");
const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLSchema,
  GraphQLNonNull
} = graphql;
let PostType, UserType;
//Hard coded users for dummy testing

// const users = [
//   { id: "23", firstName: "Rohit", age: 24 },
//   { id: "22", firstName: "Mohit", age: 20 }
// ];

UserType = new GraphQLObjectType({
  name: "User",
  fields: {
    id: { type: GraphQLString },
    // firstName: { type: GraphQLString },
    // age: { type: GraphQLInt },
    name: { type: GraphQLString },
    username: { type: GraphQLString },
    phone: { type: GraphQLString },
    company: { type: GraphQLString },
    email: { type: GraphQLString }
    // post: {
    //   type: PostType,
    //   resolve(parentValue, args) {
    //     // console.log(parentValue.id);
    //     let r = axios
    //       .get(`https://jsonplaceholder.typicode.com/posts/${parentValue.id}`)
    //       .then(resp => resp.data);
    //     // console.log(r);
    //     return r;
    //   }
    // }
  }
});

PostType = new GraphQLObjectType({
  name: "Post",
  fields: {
    id: { type: GraphQLString },
    title: { type: GraphQLString },
    body: { type: GraphQLString },
    user: {
      type: UserType,
      resolve(parentValue, args) {
        // console.log(parentValue);
        return axios
          .get(
            `https://jsonplaceholder.typicode.com/users/${parentValue.userId}`
          )
          .then(res => res.data);
      }
    }
  }
});

const RootQuery = new GraphQLObjectType({
  name: "root",
  fields: {
    user: {
      type: UserType,
      args: { id: { type: GraphQLString } },
      // resolve function used to get data from database with the args that we passed in the args
      // property of the user object
      resolve(parentValue, args) {
        // return _.find(users, { id: args.id });
        return axios
          .get(`https://jsonplaceholder.typicode.com/users/${args.id}`)
          .then(resp => resp.data);
      }
    },
    post: {
      type: PostType,
      args: { id: { type: GraphQLString } },
      resolve(parentValue, args) {
        return axios
          .get(`https://jsonplaceholder.typicode.com/posts/${args.id}`)
          .then(resp => resp.data);
      }
    }
  }
});

const mutation = new GraphQLObjectType({
  name: "Mutation",
  fields: {
    addUser: {
      type: UserType,
      args: {
        name: { type: new GraphQLNonNull(GraphQLString) },
        id: { type: GraphQLInt },
        phone: { type: GraphQLString }
      },
      resolve(parentValue, { name, id, phone }) {
        return axios
          .post(`https://jsonplaceholder.typicode.com/users/`, {
            name,
            id,
            phone
          })
          .then(res => res.data);
      }
    },
    updateUser: {
      type: UserType,
      args: {
        name: { type: GraphQLString },
        id: { type: new GraphQLNonNull(GraphQLString) },
        phone: { type: GraphQLString }
      },
      resolve(parentValue, { name, id, phone }) {
        // console.log(name, id, phone);

        return axios
          .patch(`https://jsonplaceholder.typicode.com/users/${id}`, {
            name,
            id,
            phone
          })
          .then(res => res.data);
      }
    },
    deleteUser: {
      type: UserType,
      args: {
        id: { type: new GraphQLNonNull(GraphQLInt) }
      },
      resolve(parentValue, { id }) {
        // console.log(name, id, phone);

        return axios
          .delete(`https://jsonplaceholder.typicode.com/users/${id}`)
          .then(res => res.data);
      }
    }
  }
});
module.exports = new GraphQLSchema({
  query: RootQuery,
  mutation
});
