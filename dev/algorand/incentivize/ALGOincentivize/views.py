from flask import Blueprint, render_template
from .algod import get_balance
from .forms import SendForm
from .algod import send_transaction as send_txn
from flask_login import login_required, current_user
from flask import redirect, url_for
from flask_login import logout_user
from .forms import AssetForm
main_bp = Blueprint(
    'main_bp', __name__,
    template_folder='templates',
    static_folder='static'
)

@main_bp.route('/')
@login_required
def index():
    """Main page, displays balance"""
    balance = current_user.get_balance()
    return render_template('index.html', balance=balance)
@main_bp.route('/send', methods=['GET', 'POST'])
@login_required
def send():
    """Provides a form to create and send a transaction"""
    form = SendForm()
    address = current_user.public_key
    if form.validate_on_submit():
        success = current_user.send(form.quantity.data, form.receiver.data, form.note.data)
        return render_template('success.html', success=success)

    # show the form, it wasn't submitted
    return render_template('send.html', form=form, address=address)
@main_bp.route('/logout')
@login_required
def logout():
    """User log-out logic."""
    logout_user()
    return redirect(url_for('auth_bp.login'))
@main_bp.route('/transactions')
@login_required
def transactions():
    """Displays all transactions from the user"""
    txns = current_user.get_transactions()
    return render_template('transactions.html', txns=txns)
@main_bp.route('/mnemonic')
@login_required
def mnemonic():
    """Displays the recovery passphrase"""
    passphrase = current_user.passphrase
    return render_template('mnemonic.html', passphrase=passphrase)
@main_bp.route('/assets')
@login_required
def assets():
    """Displays all assets owned by the user"""
    assets_list = current_user.get_assets()
    return render_template('assets.html', assets=assets_list)

@main_bp.route('/create', methods=['GET', 'POST'])
@login_required
def create():
    """Provides a form to create an asset"""
    form = AssetForm()
    if form.validate_on_submit():
        asset_id = current_user.create(
            form.asset_name.data,
            form.unit_name.data,
            form.total.data,
            form.decimals.data,
            form.default_frozen.data,
            form.url.data
        )

        return redirect(url_for('main_bp.assets'))

    # show the form, it wasn't submitted
    return render_template('create_asset.html', form=form)


