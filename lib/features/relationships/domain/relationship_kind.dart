enum RelationshipKind {
  guardians,
  guardees;

  String get path => switch (this) {
    RelationshipKind.guardians => 'guardians',
    RelationshipKind.guardees => 'guardees',
  };

  String get title => switch (this) {
    RelationshipKind.guardians => 'Guardians',
    RelationshipKind.guardees => 'Guardees',
  };

  String get singularTitle => switch (this) {
    RelationshipKind.guardians => 'guardian',
    RelationshipKind.guardees => 'guardee',
  };

  RequestedByRole get currentUserRole => switch (this) {
    RelationshipKind.guardians => RequestedByRole.guardee,
    RelationshipKind.guardees => RequestedByRole.guardian,
  };
}

enum RequestedByRole { guardian, guardee }
