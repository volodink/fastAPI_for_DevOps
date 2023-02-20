from typing import List, Optional
from pydantic import BaseModel


class UserBase(BaseModel):
    email: str
    username: Optional[str] = None
    full_name: Optional[str] = None
    is_active: Optional[bool] = True


class UserCreate(UserBase):
    password: str


class UserUpdate(UserBase):
    password: Optional[str] = None


class User(UserBase):
    id: int
    is_superuser: bool

    class Config:
        orm_mode = True


class UserInDB(User):
    hashed_password: str
