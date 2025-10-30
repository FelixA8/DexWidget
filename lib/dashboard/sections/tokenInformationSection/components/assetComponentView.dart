import 'package:dexwidget/dashboard/sections/tokenInformationSection/components/percentPillView.dart';
import 'package:dexwidget/models/ecrToken.dart';
import 'package:flutter/material.dart';

class AssetComponentView extends StatefulWidget {
  final ERC20Token token;
  const AssetComponentView({super.key, required this.token});

  @override
  State<AssetComponentView> createState() => _AssetComponentViewState();
}

class _AssetComponentViewState extends State<AssetComponentView>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5, // 0.5 turns = 180 degrees
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn), // Fade in after expansion starts
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    
    if (_isExpanded) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpansion,
            child: Row(
              children: [
                Image.network(
                  widget.token.logo ??
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/2048px-Bitcoin.svg.png",
                  width: 32,
                  height: 32,
                ),
                SizedBox(width: 12),
                Text(widget.token.symbol, style: TextStyle(fontFamily: 'Jura', fontSize: 18)),
                Spacer(),
                Text(formatToUSD(widget.token.usdValue), style: TextStyle(fontFamily: 'Jura', fontSize: 18)),
                SizedBox(width: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: PercentPill(value: widget.token.usdPrice24HChange),
                ),
                SizedBox(width: 8),
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159, // Convert turns to radians
                      child: Image.asset("assets/icons/chevron-up.png", width: 24, height: 24),
                    );
                  },
                )
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: _buildExpandedDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedDetails() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade700, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Token Name and Address
          _buildDetailRow("Name", widget.token.name),
          _buildDetailRow("Address", _formatAddress(widget.token.tokenAddress)),
          
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade700, thickness: 0.5),
          SizedBox(height: 12),
          
          // Balance Information
          Text(
            "Balance Information",
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          _buildDetailRow("Amount", widget.token.balanceFormatted),
          _buildDetailRow("Price", formatToUSD(widget.token.usdPrice)),
          _buildDetailRow("Total", formatToUSD(widget.token.usdValue)),
          _buildDetailRow("Avg Buy", "N/A"), // This would need historical data
          _buildDetailRow("P/L", formatToUSD(widget.token.usdValue24HChange)),
          
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade700, thickness: 0.5),
          SizedBox(height: 12),
          
          // Portfolio Information
          Text(
            "Portfolio Information",
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          _buildDetailRow("Portfolio %", "${widget.token.portfolioPercentage.toStringAsFixed(2)}%"),
          
          if (widget.token.totalSupplyFormatted != null) ...[
            SizedBox(height: 12),
            Divider(color: Colors.grey.shade700, thickness: 0.5),
            SizedBox(height: 12),
            
            // Token Supply Information
            Text(
              "Token Information",
              style: TextStyle(
                fontFamily: 'Jura',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            _buildDetailRow("Total Supply", widget.token.totalSupplyFormatted!),
            if (widget.token.percentageRelativeToTotalSupply != null)
              _buildDetailRow("% of Supply", "${widget.token.percentageRelativeToTotalSupply!.toStringAsFixed(6)}%"),
          ],
          
          SizedBox(height: 12),
          Divider(color: Colors.grey.shade700, thickness: 0.5),
          SizedBox(height: 12),
          
          // Security Information
          Text(
            "Security Information",
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          _buildDetailRow("Verified Contract", widget.token.verifiedContract ? "Yes" : "No"),
          _buildDetailRow("Possible Spam", widget.token.possibleSpam ? "Yes" : "No"),
          if (widget.token.securityScore != null)
            _buildDetailRow("Security Score", "${widget.token.securityScore}/100"),
          _buildDetailRow("Native Token", widget.token.nativeToken ? "Yes" : "No"),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Jura',
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Jura',
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(String address) {
    if (address.length <= 10) return address;
    return "${address.substring(0, 6)}...${address.substring(address.length - 4)}";
  }

  String formatToUSD(double value) {
    // Round to two decimal places
    double roundedValue = double.parse(value.toStringAsFixed(2));

    // Format as USD
    return "\$ ${roundedValue.toStringAsFixed(2)}";
  }

  String formatPercentage(double value) {
    double roundedValue = double.parse(value.toStringAsFixed(2));
    return "${roundedValue} %";
  }
}
