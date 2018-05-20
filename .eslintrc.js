module.exports = {
  extends: ["prettier", "eslint:recommended", "plugin:react/recommended"],
  parserOptions: {
    ecmaVersion: 8,
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
      modules: true
    }
  },
  globals: {
    document: true,
    window: true,
    require: true
  }
};
