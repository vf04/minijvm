module JavaParserHelper where
import AbsSyn
fieldDeclToList :: FieldDecl -> [FieldDecl]
fieldDeclToList(f) = [f]

methodDeclToList :: MethodDecl -> [MethodDecl]
methodDeclToList(m) = [m]
