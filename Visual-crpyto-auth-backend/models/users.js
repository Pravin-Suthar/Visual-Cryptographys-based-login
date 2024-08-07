module.exports = (sequelize, DataTypes) => {
  const Users = sequelize.define(
    "user",
    {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: DataTypes.INTEGER,
      },
      firstName: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      lastName: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
      profileImage: {
        type: DataTypes.BLOB,
        allowNull: true,
      },
      phoneNumber: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      dateOfBirth: {
        type: DataTypes.DATEONLY, // Store date of birth as date only
        allowNull: true,
      },
      address: {
        type: DataTypes.STRING,
        allowNull: true,
      },
      qualifications: {
        type: DataTypes.STRING, // Store qualifications as a string or JSON if multiple qualifications are needed
        allowNull: true,
      },
      isDeleted: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
      },
      createdAt: {
        allowNull: false,
        type: DataTypes.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: DataTypes.DATE,
      },
    },
    {
      timestamps: true,
      paranoid: true,
      updatedAt: "updatedAt",
      createdAt: "createdAt",
    }
  );

  // Define associations or other custom methods here

  return Users;
};
