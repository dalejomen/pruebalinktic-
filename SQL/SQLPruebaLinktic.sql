-- Crear tabla Producto
CREATE TABLE Producto (
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    Precio DECIMAL(10, 2) NOT NULL,
    FechaCreacion DATETIME DEFAULT GETDATE()
);
GO

-- Crear tabla Inventario
CREATE TABLE Inventario (
    InventarioID INT PRIMARY KEY IDENTITY(1,1),
    ProductoID INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad >= 0),
    Ubicacion NVARCHAR(100),
    FechaActualizacion DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Inventario_Producto FOREIGN KEY (ProductoID)
        REFERENCES Producto(ProductoID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
GO
--------------------------------------------------------------------------------
CREATE PROCEDURE InsertarProducto
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(255),
    @Precio DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Producto (Nombre, Descripcion, Precio)
    VALUES (@Nombre, @Descripcion, @Precio);
END;
GO
---------------------------------------------------------------------------
CREATE PROCEDURE ConsultarProductos
AS
BEGIN
    SELECT * FROM Producto;
END;
GO

-------------------------------------------------------------------------------

CREATE PROCEDURE ActualizarProducto
    @ProductoID INT,
    @Nombre NVARCHAR(100),
    @Descripcion NVARCHAR(255),
    @Precio DECIMAL(10,2)
AS
BEGIN
    UPDATE Producto
    SET Nombre = @Nombre,
        Descripcion = @Descripcion,
        Precio = @Precio
    WHERE ProductoID = @ProductoID;
END;
GO

------------------------------------------------------------------
CREATE PROCEDURE EliminarProducto
    @ProductoID INT
AS
BEGIN
    DELETE FROM Producto
    WHERE ProductoID = @ProductoID;
END;
GO

----------------------------------------------------------------------

CREATE PROCEDURE InsertarInventario
    @ProductoID INT,
    @Cantidad INT,
    @Ubicacion NVARCHAR(100)
AS
BEGIN
    INSERT INTO Inventario (ProductoID, Cantidad, Ubicacion)
    VALUES (@ProductoID, @Cantidad, @Ubicacion);
END;
GO

-------------------------------------------------------------------

CREATE PROCEDURE ConsultarInventario
AS
BEGIN
    SELECT i.InventarioID, i.ProductoID, p.Nombre AS NombreProducto,
           i.Cantidad, i.Ubicacion, i.FechaActualizacion
    FROM Inventario i
    INNER JOIN Producto p ON i.ProductoID = p.ProductoID;
END;
GO

----------------------------------------------------------------------

CREATE PROCEDURE ActualizarInventario
    @InventarioID INT,
    @Cantidad INT,
    @Ubicacion NVARCHAR(100)
AS
BEGIN
    UPDATE Inventario
    SET Cantidad = @Cantidad,
        Ubicacion = @Ubicacion,
        FechaActualizacion = GETDATE()
    WHERE InventarioID = @InventarioID;
END;
GO
----------------------------------------------------
CREATE PROCEDURE EliminarInventario
    @InventarioID INT
AS
BEGIN
    DELETE FROM Inventario
    WHERE InventarioID = @InventarioID;
END;
GO







