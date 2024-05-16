# Formación SQL

## Significado de Terminaciones AI y CI:

- **AI (Accent Insensitive):** Se ignoran los acentos al hacer comparaciones entre cadenas de texto 
(útil para búsquedas y comparaciones).

- **CI (Case Insensitive):** Se ignoran las diferencias entre mayúsculas y minúsculas 
(útil para búsquedas y comparaciones).

## Otras terminaciones existentes:

- **AS (Accent Sensitive):** Se tienen en cuenta los acentos 
(útil cuando hay que tener en cuenta los caracteres acentuados de los no acentuados).

- **CS (Case Sensitive):** Se tienen en cuenta la diferencia entre mayúsculas y minúsculas.

- **KS (Kanatype Sensitive):** Se tienen en cuenta los caracteres Kana en el idioma Japonés, las diferencias de caracteres Hiragana y Katakana.

- **WS (Width Sensitive):** Se tienen en cuenta las diferencias de ancho entre caracteres. 
Esto se debe a que algunos caracteres tienen un ancho de visualización diferente 
(algunos caracteres pueden ocupar dos espacios de visualización).

- **VS (Variation Selector Sensitivity):** Se tienen en cuenta la presencia de diferentes selectores de variación 
(caracteres Unicode para cambiar la visualización de otros caracteres Unicode).

- **BIN (Binary):** Permite la compatibilidad con el ordenamiento binario.

- **BIN2 (Binary-code point):** Permite el ordenamiento y la comparación para datos Unicode.

- **UTF8:** Especifica que puede usarse UTF-8 para los tipos compatibles.


# Tipos de Datos


| Tipo de Dato | Tamaño | Uso |
|--------------|--------|-----|
| Char         | El espacio especificado | Almacena cadenas de caracteres de tamaño fijo (8000 caracteres) |
| Varchar      | Espacio especificado + 2 bytes | Almacena cadenas de caracteres de tamaño variable (8000 caracteres) |
| Text         | Espacio especificado + 4 bytes | Almacena cadenas de caracteres de tamaño variable. Cuando supera el límite de char y varchar (2,147,483,647 caracteres) |
| Nchar        | 2 veces el espacio especificado | Almacena cadenas de caracteres de tamaño fijo basados en Unicode (4000 caracteres) |
| Nvarchar     | 2 veces el espacio especificado | Almacena cadenas de caracteres de tamaño variable basados en Unicode (4000 caracteres) |
| Ntext        | 2 veces del string | Almacena cadenas de caracteres de tamaño variable basados en Unicode. Cuando supera el límite de nchar y nvarchar (1,073,741,823 caracteres) |
| Int          | 4 bytes | Almacena cualquier entero dentro de su capacidad (-2,147,483,647 / 2,147,483,647) |
| Smallint     | 2 bytes | Almacena cualquier entero dentro de su capacidad (-32,768 / 32,768) |
| Decimal      | Entre 5 y 17 bytes | Almacena cualquier valor decimal dentro de su capacidad (-10^38+1 / 10^38+1) |
| Float        | Entre 4 y 8 bytes | Números aproximativos dentro de su capacidad (-1.79E +308 / 1.79E +308) |
| Bigint       | 8 bytes | Almacena cualquier entero dentro de su capacidad |
| Numeric      | Entre 5 y 17 bytes | Almacena cualquier valor decimal dentro de su capacidad. Idéntico al decimal (-10^38+1 / 10^38+1) |
| Bit          | 1 byte | Campo binario |
| Money        | 8 bytes | Valores de moneda. Más capacidad que el smallmoney (-922,337,203,685,477.5808 /922,337,203,685,477.5807) |
| Smallmoney   | 4 bytes | Valores de moneda (214,478.3647 /-214,478.3648) |
| Real         | 4 bytes | Números aproximativos dentro de su capacidad (-214,478.3648 / 214,478.3648) |
| Tinyint      | 1 byte | Almacena números enteros (255) |
| Date         | 3 bytes | Almacena solo fechas (01/01/0001 – 31/12/9999) |
| Time         | 5 bytes | Almacena solo horas, 100ns de precisión (00:00:00.0000000 – 23:59:59.9999999) |
| Datetime     | 8 bytes | Almacena fechas con horas con precisión en segundos de .000, .003, .007 (01/01/1900 00:00:00 – 31/12/999 23:59:59) |
| Datetime2    | Entre 6 y 8 bytes | Almacena fechas con horas con precisión de 100ns ente 0 y7 dígitos. Mejor precisión que datetime (01/01/0001 00:00:00 - 31/12/999 23:59:59.9999999) |
| Datetimeoffset | 10 bytes | Similar a datetime2 pero con el offset de la zona horaria (-14 / 14 horas) |
| Smalldatetime | 4 bytes | Almacena fechas con horas con precisión de 1 minuto (01/01/1900 00:00:00 - 06/06/2079 23:59:59) |
| Varbinary    | Espacio del string +2 bytes | Almacena un string binario de tamaño fijo o variable (800 bytes) |
| Binary       | Espacio disponible | Almacena un string binario de tamaño fijo |
| Uniqueidentifier | 16 bytes | Genera un GUID |
| Xml          |  | Almacena XML en una columna |
| Image        | Espacio disponible en su rango | Almacena una imagen en formato binario |
| Geography    |  | Almacena datos de tipo espacial como GPS |
| Geometry     |  | Almacena datos en sistema de coordenadas |
| Hierachyid   |  | Representa la posición dentro de una jerarquía |
| Rowversion   |  | Almacena un valor binario único autogenerado a nivel de base de datos |

# Int autonumérico vs unique identifier

Son dos formas diferentes de generar identificadores.

1. **Espacio de almacenamiento:**
   - INT: Ocupa 4 bytes de almacenamiento.
   - UNIQUEIDENTIFIER: Ocupa 16 bytes de almacenamiento.
   
2. **Generación de valores:**
   - INT: Sin atributos adicionales, no genera valores automáticamente. Debes proporcionar explícitamente los valores al insertar filas en la tabla.
   - UNIQUEIDENTIFIER: Los valores se generan automáticamente utilizando algoritmos que garantizan la unicidad global.
   
3. **Eficiencia y velocidad:**
   - INT: Es más eficiente en términos de espacio de almacenamiento y velocidad de búsqueda debido a su tamaño más pequeño y su naturaleza secuencial.
   - UNIQUEIDENTIFIER: Tiene un tamaño de 16 bytes y requiere más recursos de almacenamiento y procesamiento en comparación con INT.
   
4. **Unicidad:**
   - INT: Los valores de una columna INT no necesariamente son únicos, a menos que se aplique una restricción de unicidad o sea utilizada como clave primaria.
   - UNIQUEIDENTIFIER: Los valores son globalmente únicos, lo que significa que son únicos no solo dentro de una tabla, sino también en todas las bases de datos y servidores.
   
5. **Usos:**
   - INT: Adecuado para identificadores simples dentro de una base de datos donde la unicidad global no es un requisito.
   - UNIQUEIDENTIFIER: Adecuado para identificadores únicos globales en entornos distribuidos donde la unicidad global es crucial.

# Cuando es adecuado usar default values en el diseño de una tabla

1. **Valores predeterminados comunes:** Cuando la mayoría de las filas en una tabla tienen un valor común para una columna, establecer ese valor como predeterminado puede simplificar las inserciones de datos y reducir la cantidad de código necesario en las aplicaciones para gestionar esos casos.

2. **Seguridad de datos:** Al establecer un valor predeterminado para una columna, puedes garantizar que siempre haya un valor válido presente, incluso si la aplicación no proporciona uno explícitamente. Esto puede ayudar a mantener la integridad de los datos y evitar errores de inserción.

3. **Mejora de la consistencia:** Al proporcionar un valor predeterminado para una columna, puedes asegurarte de que todas las filas nuevas tengan ciertos campos inicializados de la misma manera, lo que puede mejorar la consistencia de los datos en la tabla.

4. **Compatibilidad con versiones anteriores:** Al agregar una nueva columna a una tabla existente, establecer un valor predeterminado para esa columna puede garantizar que las aplicaciones existentes que insertan datos en esa tabla no se rompan debido a la falta de un valor para la nueva columna.

5. **Optimización del rendimiento:** En algunas situaciones, establecer un valor predeterminado puede ayudar a mejorar el rendimiento de las consultas, especialmente cuando se trata de búsquedas y filtros en los que el valor predeterminado se utiliza con frecuencia.

## Ejemplo:

```sql
CREATE TABLE Usuarios (
    ID INT PRIMARY KEY,
    FechaRegistro DATE DEFAULT GETDATE(),
    EstadoActivo BIT DEFAULT 1
); 
```


La columna FechaRegistro tiene un valor predeterminado `GETDATE()`, que establece automáticamente la fecha de registro del usuario en la fecha actual cuando no se proporciona explícitamente un valor durante la inserción.

La columna EstadoActivo tiene un valor predeterminado de `1`, lo que indica que el usuario está activo por defecto.

# Ventajas y desventajas columnas con/sin nulos

**Ventajas de permitir valores nulos:**

- **Flexibilidad en los datos:**
 Permite representar datos faltantes o desconocidos de manera explícita, lo que puede ser útil en situaciones donde no todos los valores son conocidos o relevantes.

- **Ahorro de espacio:** 
Los valores nulos no ocupan espacio de almacenamiento en la base de datos, lo que puede ayudar a reducir el consumo de recursos, especialmente en columnas que tienden a tener muchos valores nulos.
- **Compatibilidad con estándares de datos:**
 Algunos estándares de datos o convenciones pueden requerir que ciertas columnas admitan valores nulos para cumplir con los requisitos de representación de datos.

**Desventajas de permitir valores nulos:**

- **Complejidad en las consultas:** 
Las consultas que involucran columnas con valores nulos pueden volverse más complejas, ya que es necesario tener en cuenta la posibilidad de valores nulos y manejarlos adecuadamente en las cláusulas WHERE o en las operaciones de JOIN.

- **Mayor riesgo de errores:** 
El manejo incorrecto de valores nulos en las consultas puede provocar resultados inesperados o errores en la lógica de la aplicación, especialmente si no se tiene en cuenta la posibilidad de valores nulos.

- **Integridad de los datos:** 
Los valores nulos pueden dificultar el mantenimiento de la integridad de los datos, ya que es posible introducir inconsistencias si no se manejan adecuadamente.

# Diagrama base de datos Invoices

![Texto alternativo](images/Diagram_Invoices.png)


# Campos clave compuestos

Implica utilizar más de un campo para crear la PK.

**Cuando es buena práctica usarlos:**

1. **Cuando el modelado es complejo:**
Si para identificar una tabla es necesario otro campo más ya que para identificarla es necesario más datos. Ejemplo: un prestamo de una biblioteca, su clave podria ser el Id del libro y el Id del usuario a quien se lo ha prestado.   

2. **Evitar duplicaciones:**
A veces con un campo clave no es suficiente para evitar duplicidad de registros.
Por ejemplo un empleado que tenga el mismo nombre y distinto nº de identificación.

3. **Optimización de consultas:**
Puede ser más eficiente incluir una clave compuesta con los campos que se utilizan mas frecuentemente.

4. **Normalización:**
A veces es necesario utilizar campos clave compuestos para satisfacer ciertas formas normales. Ejemplo: en la tercera **forma normal** (3NF), todas las columnas no clave deben depender únicamente de la clave principal.

5. **Complejidad y mantenibilidad:**
Utilizar campos clave compuestos puede agregar complejidad al diseño de la base de datos y a las consultas que interactúan con ella. Es importante considerar si esta complejidad es justificada por las necesidades del sistema y si se puede mantener a lo largo del tiempo.

## Formas normales
Las formas normales son reglas que se aplican al diseño de bases de datos relacionales para reducir la redundancia de datos y mejorar la integridad de los mismos. Hay varias formas normales, que se denotan como 1NF, 2NF, 3NF, BCNF (Forma Normal de Boyce-Codd), 4NF y 5NF. Aquí te proporciono una descripción general de cada una:

- **Primera Forma Normal (1NF):**
  - En 1NF, todos los atributos de una relación deben ser atómicos, es decir, no deben tener valores múltiples o repetidos.
  - Cada celda en una tabla debe contener un solo valor, no conjuntos de valores.

- **Segunda Forma Normal (2NF):**
  - Una tabla está en 2NF si está en 1NF y todos sus atributos no clave dependen completamente de la clave primaria.
  - Si la tabla tiene una clave primaria compuesta, cada atributo no clave debe depender de la totalidad de la clave, no de solo una parte de ella.

- **Tercera Forma Normal (3NF):**
  - Una tabla está en 3NF si está en 2NF y no tiene dependencias transitivas.
  - Esto significa que ningún atributo no clave debe depender de otro atributo no clave. Todos los atributos no clave deben depender directamente de la clave primaria.

- **Forma Normal de Boyce-Codd (BCNF):**
  - Similar a la 3NF, pero más estricta en cuanto a la eliminación de redundancias.
  - Una tabla está en BCNF si, para cada dependencia funcional no trivial X → Y, X es una superclave.
  - En otras palabras, cada determinante de una dependencia funcional debe ser una superclave, lo que significa que no puede haber dependencias funcionales no triviales de atributos que no son claves.

- **Cuarta Forma Normal (4NF):**
  - Introduce el concepto de independencia multivaluada.
  - Una tabla está en 4NF si no tiene dependencias multivaluadas y dependencias funcionales entre atributos no clave.

- **Quinta Forma Normal (5NF):**
  - También conocida como Proyección de Junta de Proyección y Dependencia (PJ/NF)
  - Es una forma normal extremadamente rara y no se aplica comúnmente en el diseño de bases de datos.


# Ventajas / desventajas campos calculados y triggers

## Ventajas campos calculados

- **Simplicidad:** Simplifica las consultas.
- **Consistencia de datos:** Garantiza que los datos se actualicen automatica y correctamente.
- **Rendimiento:** Si se almacenan en la base de atos, mejoran el rendimiento ya que evitan recalcular los datos en cada consulta.

## Desventajas campos calculados

- **Uso de recursos:** Pueden consumir recursos CPU y almacenamiento
- **Complejidad de mantenimiento:** Añaden complejidad adicional al diseño de la base de datos y el mantenimiento del código.

## Ventajas triggers

- **Automatización de acciones:** Permiten la automatización de acciones, como actualizacion de datos en otras tablas, envío de notificaciones, en función de los eventos.

- **Integridad de los datos:** Garantizan la integridad al aplicar reglas de negocio o restricciones que no pueden ser expresadas por clave externa o de integridad referencial.

## Desventajas triggers

- **Complejidad y mantenibilidad:** Añaden complejidad adicional al diseño y mantenimiento de la base de datos.

- **Impacto en el rendimiento:** Pueden agregar sobrecarga adicional, sobretodo en tablas con muchos registros o en sistemas con alta concurrencia

# Diferentes collation en campos de una misma tabla

## Limitaciones

- **Comparaciones y ordenamientos:**

Pueden fallar los resultados en la comparaciones y ordenamiento de esos campos, ya que los collation determinan como se ordenan y comparan los datos.

- **Indexación:**

La creación de índices en campos con diferentes collation puede ser complicado o imposible en función de algunos sistemas de gestión de la base de datos. Afecta al rendimiento de las consultas.

- **Join y uniones:**

Al hacer un JOIN o UNION entre tablas que contengan campos con diferente collation  es probable que se produzcan error o resultados inexperados por la comparción que se realiza de los datos.

- **Conversiones implícitas:**

Puede que el sistema de gestión de la base de datos realize conversiones ímplicitas de tipos de datos para que coincida el collation. Afecta al rendimiento y precisión de las consultas.

- **Costo de almacenamiento:**

Es posible que se incremente el coste de almacenamiento ya que almancena información adicional por cada collation utilizado.

# Ventajas/ desventajas campos calculados:

## Ventajas:
- **Eficiencia en el almacenamiento de datos:** Los campos calculados pueden ayudar a reducir la redundancia de datos al calcular valores en lugar de almacenarlos físicamente. Esto puede resultar en un uso más eficiente del espacio de almacenamiento.

- **Consistencia de datos:** Al calcular valores en lugar de almacenarlos, se garantiza que los datos sean coherentes y estén actualizados en todo momento. Esto elimina la posibilidad de inconsistencias debido a errores humanos o actualizaciones incompletas.

- **Facilidad de mantenimiento:** Los campos calculados simplifican el mantenimiento de la base de datos al eliminar la necesidad de actualizar valores calculados manualmente cuando cambian los datos subyacentes. Esto reduce la carga de trabajo administrativa y minimiza el riesgo de errores.

- **Mejora del rendimiento de consultas:** Al calcular valores durante la consulta en lugar de recuperarlos de la base de datos, se puede mejorar el rendimiento de las consultas al evitar cálculos repetitivos o complejos en tiempo de ejecución.

## Desventajas:
- **Complejidad de la lógica de cálculo:** A medida que se agregan más campos calculados y la lógica de cálculo se vuelve más compleja, puede ser difícil de entender y mantener. Esto puede llevar a errores y dificultar la depuración.

- **Impacto en el rendimiento de actualizaciones y operaciones de escritura:** Los campos calculados pueden ralentizar las operaciones de escritura, especialmente si involucran cálculos complejos o grandes volúmenes de datos. Esto se debe a que cada actualización puede desencadenar el recálculo de los valores calculados.

- **Limitaciones de plataforma y compatibilidad:** Algunas plataformas de base de datos pueden tener limitaciones en cuanto a la complejidad o el tipo de cálculos que se pueden realizar en campos calculados. Además, la compatibilidad entre diferentes sistemas de gestión de bases de datos puede variar, lo que puede afectar la portabilidad de la aplicación.

- **Mayor consumo de recursos:** Si los cálculos son intensivos en recursos, como operaciones matemáticas complejas o funciones definidas por el usuario, los campos calculados pueden aumentar el consumo de recursos del servidor de base de datos y afectar el rendimiento general del sistema.
