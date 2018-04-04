import threading


lock = threading.Lock()


def with_lock(fn):
    '''Protect resource from concurrent access'''
    def wrapper(*args, **kwargs):
        with lock:
            fn(*args, **kwargs)
    return wrapper


def with_positive_val(fn):
    '''Check if argument is positive'''
    def wrapper(acc, amount):
        if amount < 0:
            raise ValueError('Cannot use negative value.')
        else:
            fn(acc, amount)
    return wrapper


def with_open_acc(fn):
    '''Check if account is open'''
    def wrapper(acc, *args):
        if acc.is_open:
            result = fn(acc, *args)
        else:
            raise ValueError('Account is closed')
        return result
    return wrapper


class BankAccount():
    def __init__(self, initial_balance=0, is_open=False):
        self.balance = initial_balance
        self.is_open = is_open

    @with_open_acc
    def get_balance(self):
        return self.balance

    @with_lock
    def open(self):
        self.is_open = True

    @with_open_acc
    @with_positive_val
    @with_lock
    def deposit(self, amount):
        self.balance += amount

    @with_open_acc
    @with_positive_val
    @with_lock
    def withdraw(self, amount):
        new_balance = self.balance - amount
        if new_balance < 0:
            raise ValueError('Withdraw exceeds availiable funds.')
        self.balance -= amount

    @with_open_acc
    @with_lock
    def close(self):
        self.is_open = False
