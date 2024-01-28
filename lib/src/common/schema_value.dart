/// SchemaValue - Abstract Class for Schema Elements
///
/// This abstract class serves as the base for schema elements in the `EzSchema` system.
/// It is designed to enforce type safety within the `EzSchema` class, ensuring that the schema
/// can only contain elements that are either instances of `EzValidator` or `EzSchema`.
abstract class SchemaValue {}
