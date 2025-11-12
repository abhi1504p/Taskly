class UserModel {
    final String id;
    final String email;
    final String name;
    final String token;
    final String createdAt;
    final String updatedAt;

    //<editor-fold desc="Data Methods">
    const UserModel({
        required this.id,
        required this.email,
        required this.name,
        required this.token,
        required this.createdAt,
        required this.updatedAt,
    });

    @override
    bool operator==(Object other) =>
    identical(this, other) ||
        (other is UserModel &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            email == other.email &&
            name == other.name &&
            token == other.token &&
            createdAt == other.createdAt &&
            updatedAt == other.updatedAt);

    @override
    int get hashCode =>
    id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        token.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;

    @override
    String toString() {
        return 'UserModel{' +
            ' id: $id,' +
            ' email: $email,' +
            ' name: $name,' +
            ' token: $token,' +
            ' createdAt: $createdAt,' +
            ' updatedAt: $updatedAt,' +
            '}';
    }

    UserModel copyWith({
        String? id,
        String? email,
        String? name,
        String? token,
        String? createdAt,
        String? updatedAt,
    }) {
        return UserModel(
            id: id ?? this.id,
            email: email ?? this.email,
            name: name ?? this.name,
            token: token ?? this.token,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'id': this.id,
            'email': this.email,
            'name': this.name,
            'token': this.token,
            'createdAt': this.createdAt,
            'updatedAt': this.updatedAt,
        };
    }

    factory UserModel.fromMap(Map<String, dynamic> map) {
        return UserModel(
            id: map['id'] ??'',
            email: map['email'] ??'',
            name: map['name'] ??'',
            token: map['token'] ??'',
            createdAt: map['createdAt'] ,
            updatedAt: map['updatedAt'] ,
        );
    }
    //</editor-fold>
}
